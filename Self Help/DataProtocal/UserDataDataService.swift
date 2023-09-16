//
//  UserDataDataService.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/9/23.
//



import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

protocol UserDataService: ObservableObject {
    
    func get() -> AnyPublisher<[UserData], Error>
    func add(_ userData: UserData)
    func update(_ userData: UserData)
    func delete(_ userData: UserData)
    
}




class UserFirebaseDataService: UserDataService {
    
    
    
    private let db = Firestore.firestore()
    private let collectionName = "userdata"
    
    @Published private var userdatas: [UserData] = []
      
    
    init() {
        // Load initial data from Firebase when the app starts
        loadUserData()
    }
    
    func get() -> AnyPublisher<[UserData], Error> {
        return Just(userdatas)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    
    func add(_ userData: UserData) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        var userDataWithUserId = userData
        userDataWithUserId.userId = userId
        
        do {
            let documentReference = try db.collection(collectionName).addDocument(from: userDataWithUserId)
            userDataWithUserId.documentId = documentReference.documentID
        } catch {
            print("Error adding userData to Firestore: \(error)")
        }
    }
    
    func update(_ userData: UserData) {
        if let documentID = userData.id {
            // If userData has an ID, update the existing document
            do {
                var updatedData = userData
                updatedData.documentId = documentID // Update the documentId field
                try db.collection("userdata").document(documentID).setData(from: updatedData)
            } catch {
                print("Error updating userData in Firestore: \(error)")
            }
        } else {
            // If userData doesn't have an ID, create a new document
            do {
                var newData = userData
                let documentReference = try db.collection("userdata").addDocument(from: newData)
                newData.id = documentReference.documentID // Update the ID in your model
                newData.documentId = documentReference.documentID // Update the documentId field
            } catch {
                print("Error adding userData to Firestore: \(error)")
            }
        }
    }




    
    func delete(_ userData: UserData) {
        guard let documentID = userData.id else {
            return
        }
        let db = Firestore.firestore()
        db.collection(collectionName).document(documentID).delete { error in
            if let error = error {
                print("Error deleting userData from Firestore: \(error)")
            } else {
                print("UserData deleted successfully.")
            }
        }
    }
    
    private func loadUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        db.collection(collectionName)
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching user data: \(error)")
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    print("No documents found.")
                    return
                }
                
                self.userdatas = documents.compactMap { document in
                    do {
                        return try document.data(as: UserData.self)
                    } catch {
                        print("Error decoding user data: \(error)")
                        return nil
                    }
                }
            }
    }
    
  
}
