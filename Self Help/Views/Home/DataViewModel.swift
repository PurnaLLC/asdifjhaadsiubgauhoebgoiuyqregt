//
//  DataViewModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/27/23.
//
import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore

class DataViewModel: ObservableObject {
    @Published var dataOfTheDay: DataOfTheDay?

    init() {
        fetchData()
        
    }

    func fetchData() {
        fetchDataOfTheDay { [weak self] data in
            DispatchQueue.main.async {
                self?.dataOfTheDay = data
            }
        }
    }
    
    
    
    
    func fetchAffirmation() {
           let db = Firestore.firestore()
           db.collection("affirmations").getDocuments { snapshot, error in
               if let error = error {
                   print("Error fetching data: \(error)")
                   return
               }

               guard let documents = snapshot?.documents else {
                   print("No documents found")
                   return
               }

           }
       }
    
    
    
        
    
    
    
    
    
}
