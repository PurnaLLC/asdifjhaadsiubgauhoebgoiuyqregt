//
//  ChatViewData.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/27/23.
//


import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import Combine




struct Affirmation:  Identifiable, Codable {
    var id: String
    var affirmation: String
    var date: Date
    var type: String



}




class AffirmationViewModel: ObservableObject {
    @Published private(set) var affirmations: [Affirmation] = []

    
    private let ds: any AffirmationDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(ds: any AffirmationDataService = AffirmationFirebaseDataService()) {
        self.ds = ds
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { affirmations in
                self.affirmations = affirmations
            }
            .store(in: &cancellables)
        
        
        
    }
    
    
}







protocol AffirmationDataService: ObservableObject {
    
    func get() -> AnyPublisher<[Affirmation], Error>
   
}






class AffirmationFirebaseDataService: AffirmationDataService {

    
    
    private let db = Firestore.firestore()
    private let collectionName = "affimations"
    
    
    

    @Published private var affirmations: [Affirmation] = []

    init() {
        // Load initial data from Firebase when the app starts
        loadAffirmations()
        
        
    }


    func get() -> AnyPublisher<[Affirmation], Error> {
        return $affirmations.tryMap({$0}).eraseToAnyPublisher()
    }
    

    
    private func loadAffirmations() {
        let db = Firestore.firestore()
        db.collection("affimations")
            .order(by: "date")
            .limit(to: 6)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching affirmations: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    
                    // Parse and map the data to Affirmation objects
                    let fetchedAffirmations = documents.compactMap { document -> Affirmation? in
                        let data = document.data()
                        guard
                            let affirmation = data["affirmation"] as? String,
                            let timestamp = data["date"] as? Timestamp,
                            let type = data["type"] as? String
                        else { return nil }
                        
                        let date = timestamp.dateValue() // No need for optional binding here
                        
                        return Affirmation(id: document.documentID, affirmation: affirmation, date: date, type: type)
                    }
                    
                    // Set the fetched affirmations as the loaded affirmations
                    self.affirmations = fetchedAffirmations
                }
        }
    }





       
}







