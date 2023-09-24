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
    
  //  func get() -> AnyPublisherUserData, Error>

  

    func get() -> AnyPublisher<[UserData], Error>
    
    
    func increaseStreak(_ userId: String, currentStreak: Int)
    
    func updateUserDataInFirestore( _ userId : String, newStreak: Int)
    
      
    
    
    
    
}




class UserFirebaseDataService: UserDataService {

    
    
    
    
    @Published private var userDatas: [UserData] = []
    
  
    private let firestoreCollection = Firestore.firestore().collection("usersdata")
    
    private let db = Firestore.firestore()

    
    
    
    init() {
        // Load initial data from Firebase when the app starts
        loadUserData()
    }
    
    
    func delete(_ userData: UserData) {
        
    }
    
    
    
    
    
    func get() -> AnyPublisher<[UserData], Error> {
        return $userDatas.tryMap({$0}).eraseToAnyPublisher()
        
        
    }
    
    
    func increaseStreak(_ userId: String, currentStreak: Int) {
        let newStreak = currentStreak + 1

        updateUserDataInFirestore(userId, newStreak: newStreak)
    }


    
    
    
    
    func updateUserDataInFirestore( _ userId : String, newStreak: Int) {
        
        
        let userDocumentRef = firestoreCollection.document(userId) // Replace 'userId' with the appropriate user ID
        
        // Create a dictionary with the updated userData fields
        let updatedData: [String: Any] = [
            "streak": newStreak
            // Add other fields if needed
        ]
        
        // Update the Firestore document with the new data
        userDocumentRef.updateData(updatedData) { error in
            if let error = error {
                print("Error updating UserData in Firestore: \(error.localizedDescription)")
            } else {
                print("UserData updated successfully")
            }
        }
    }
    
    
    
    private func loadUserData() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }

        firestoreCollection.whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching user data: \(error)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("No documents found.")
                    return
                }

                // Update user data by appending documents
                self.userDatas = documents.compactMap { document in
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
