//
//  ChallengeData.swift
//  Self Help
//
//  Created by Maxwell Meyer on 10/1/23.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore



struct Challenge:  Identifiable, Codable {
    var id: String
    var challenge: String
    var date: Date
}




class ChallengesViewModel: ObservableObject {
    @Published private(set) var challenges: [Challenge] = []

    
    private let ds: any ChallengeDataProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(ds: any ChallengeDataProtocol = ChallengeFirebaseDataService()) {
        self.ds = ds
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { challenges in
                self.challenges = challenges
            }
            .store(in: &cancellables)
        
        
        
    }
    
    

}







protocol ChallengeDataProtocol: ObservableObject {
    
    func get() -> AnyPublisher<[Challenge], Error>
   
}






class ChallengeFirebaseDataService: ChallengeDataProtocol {

    
    
    private let db = Firestore.firestore()
    private let collectionName = "challenges"
    
    
    

    @Published private var challenges: [Challenge] = []

    init() {
        // Load initial data from Firebase when the app starts
        loadChallenges()
        
        
    }


    func get() -> AnyPublisher<[Challenge], Error> {
        return $challenges.tryMap({$0}).eraseToAnyPublisher()
    }
    

    
    private func loadChallenges() {
        let db = Firestore.firestore()
        db.collection("challenges")
            .order(by: "date")
            .limit(to: 1)
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error fetching challenges: \(error)")
                } else {
                    guard let documents = querySnapshot?.documents else { return }
                    
                    // Parse and map the data to Affirmation objects
                    let fetchedChallenges = documents.compactMap { document -> Challenge? in
                        let data = document.data()
                        guard
                            let challenge = data["challenge"] as? String,
                            let timestamp = data["date"] as? Timestamp
                    //        let type = data["type"] as? String
                        else { return nil }
                        
                        let date = timestamp.dateValue() // No need for optional binding here
                        
                        return Challenge(id: document.documentID, challenge: challenge , date: date )
                    }
                    
                    // Set the fetched affirmations as the loaded affirmations
                    self.challenges = fetchedChallenges
                }
        }
    }





       
}










