//
//  MessageDataService.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/26/23.


import Foundation
import Firebase
import Combine

protocol MessageDataService: ObservableObject {
    
    func get() -> AnyPublisher<[FirebaseMessage], Error>
    func add(_ firebaseMessage: FirebaseMessage)

}




class FirebaseMessageDataService: MessageDataService {

    
  
    
    
    private let db = Firestore.firestore()
    private let collectionName = "firebaseMessages"

    @Published private var messages: [FirebaseMessage] = []

    init() {
        // Load initial data from Firebase when the app starts
        loadMessages()
        
        
    }

    func get() -> AnyPublisher<[FirebaseMessage], Error>{
        return $messages.tryMap({$0}).eraseToAnyPublisher()
    }

    func add(_ firebaseMessage: FirebaseMessage) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        var checkinWithUserId = firebaseMessage
        checkinWithUserId.userId = userId

        do {
            let documentReference = try db.collection(collectionName).addDocument(from: checkinWithUserId)
            checkinWithUserId.documentId = documentReference.documentID
        } catch {
            print("Error adding checkin to Firestore: \(error)")
        }
    }




        private func loadMessages() {
                guard let userId = Auth.auth().currentUser?.uid else {
                    print("User is not authenticated.")
                    return
                }

                db.collection(collectionName)
                    .whereField("userId", isEqualTo: userId)
                    .addSnapshotListener { querySnapshot, error in
                    if let error = error {
                        print("Error fetching checkins: \(error)")
                        return
                    }

                    guard let documents = querySnapshot?.documents else {
                        print("No documents found.")
                        return
                    }

                    self.messages = documents.compactMap { document in
                        do {
                            return try document.data(as: FirebaseMessage.self)
                        } catch {
                            print("Error decoding checkin: \(error)")
                            return nil
                        }
                    }
                }
            }
   
    


       
}
