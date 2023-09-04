//
//  CheckInDataService.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/4/23.
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
    func delete(indexSet: IndexSet)
}

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
    
    func delete(indexSet: IndexSet) {
        checkins.remove(atOffsets: indexSet)
    }
}

class UserDefaultDataService: DataService {
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
    
    func delete(indexSet: IndexSet) {
        checkins.remove(atOffsets: indexSet)
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
            _ = try db.collection(collectionName).addDocument(from: checkinWithUserId)
        } catch {
            print("Error adding checkin to Firestore: \(error)")
        }
    }

    func update(_ checkin: CheckIn) {
        if let index = checkins.firstIndex(where: { $0.id == checkin.id }) {
            checkins[index] = checkin
            do {
                try db.collection(collectionName).document(checkin.id.uuidString).setData(from: checkin)
            } catch {
                print("Error updating checkin in Firestore: \(error)")
            }
        }
    }

    func delete(indexSet: IndexSet) {
        let checkinsToDelete = indexSet.map { checkins[$0] }
        for checkin in checkinsToDelete {
            if let index = checkins.firstIndex(where: { $0.id == checkin.id }) {
                checkins.remove(at: index)
                do {
                    try db.collection(collectionName).document(checkin.id.uuidString).delete()
                } catch {
                    print("Error deleting checkin from Firestore: \(error)")
                }
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
