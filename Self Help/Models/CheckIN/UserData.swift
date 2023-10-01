//
//  UserData.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/9/23.
//


import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore



struct UserData: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var userId = ""
    var documentId: String? // Store the Firestore document ID here
    var lastcheckin = Date(timeIntervalSinceReferenceDate: 0)
    var streak = 0

    
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    
    
    func formattedLastCheckinDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: date)
    }

    
    
    
}
