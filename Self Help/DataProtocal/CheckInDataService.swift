//
//  CheckInDataService.swift
//  Self Help
//
//  Created by Maxwell Meyer on 10/5/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

protocol DataService: ObservableObject {
    
    func get() -> AnyPublisher<[CheckIn], Error>
    func add(_ checkin: CheckIn)
    func update(_ checkin: CheckIn)
    func delete(_ checkin: CheckIn)
    

   
}

//please show up


class MockDataService: DataService {
    

    
    @Published private var checkins: [CheckIn] = []
    
    func get() -> AnyPublisher<[CheckIn], Error> {
        $checkins.tryMap({$0}).eraseToAnyPublisher()
    }
    
    func add(_ checkin: CheckIn) {
        checkins.append(checkin)
    }
    
    func update(_ checkin: CheckIn) {
        guard let index = checkins.firstIndex(where: {$0.id == checkin.id}) else { return }
        checkins[index] = checkin
    }
    
    func delete(_ checkin: CheckIn) {
        checkins.removeAll { $0.id == checkin.id }
    }
   
    
    
}

class UserDefaultDataService: DataService {
    
    private let db = Firestore.firestore()
    private let collectionName = "checkins"
    
    
    @Published private var checkins: [CheckIn] {
        didSet {
            save(items: checkins, key: key)
        }
    }
    
    private var key = "UserDefaultDataService"
    init(){
        checkins = []
        checkins = load(key: key)
    }
    func get() -> AnyPublisher<[CheckIn], Error> {
        $checkins.tryMap({$0}).eraseToAnyPublisher()
    }
    
    func add(_ item: CheckIn) {
        checkins.append(item)
    }
    
    func update(_ item: CheckIn) {
        guard let index = checkins.firstIndex(where: {$0.id == item.id}) else { return }
        checkins[index] = item
    }
    
    func delete(_ checkin: CheckIn) {
        checkins.removeAll { $0.id == checkin.id }
        save(items: checkins, key: key)
    }

    // MARK: Private
    func save<T: Identifiable & Codable> (items: [T], key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode (items) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    func load<T: Identifiable & Codable> (key: String) -> [T] {
        guard let data = UserDefaults.standard.object (forKey: key) as? Data else {return [] }
        let decoder = JSONDecoder()
        if let dataArray = try? decoder.decode ([T].self, from: data) {
            return dataArray
        }
        return []
    }
    
}





class FirebaseDataService: DataService {
  
    
    
    private let db = Firestore.firestore()
    private let collectionName = "checkins"

    @Published private var checkins: [CheckIn] = []

    init() {
        // Load initial data from Firebase when the app starts
        loadCheckins()
        
        
    }

    func get() -> AnyPublisher<[CheckIn], Error> {
        return $checkins.tryMap({$0}).eraseToAnyPublisher()
    }

    func add(_ checkin: CheckIn) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        var checkinWithUserId = checkin
        checkinWithUserId.userId = userId

        do {
            let documentReference = try db.collection(collectionName).addDocument(from: checkinWithUserId)
            checkinWithUserId.documentId = documentReference.documentID
        } catch {
            print("Error adding checkin to Firestore: \(error)")
        }
    }


    func update(_ checkin: CheckIn) {
        if let index = checkins.firstIndex(where: { $0.id == checkin.id }) {
            checkins[index] = checkin
            do {
                try db.collection(collectionName).document(checkin.id ?? "").setData(from: checkin)
            } catch {
                print("Error updating checkin in Firestore: \(error)")
            }
        }
    }

    func delete(_ checkin: CheckIn) {
        guard let documentID = checkin.id else {
            return
        }
        let db = Firestore.firestore()
        db.collection(collectionName).document(documentID).delete { error in
            if let error = error {
                print("Error deleting checkin from Firestore: \(error)")
            } else {
                print("Checkin deleted successfully.")
            }
        }
    }

        private func loadCheckins() {
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

                    self.checkins = documents.compactMap { document in
                        do {
                            return try document.data(as: CheckIn.self)
                        } catch {
                            print("Error decoding checkin: \(error)")
                            return nil
                        }
                    }
                }
            }
   
    


       
}
