//
//  ChatInListModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/3/23.
//

import Foundation
import FirebaseFirestoreSwift



struct CheckIn: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var date = Date()
    var name = ""
    var day1to10 = 0
    var userId = ""
    var documentId: String? // Store the Firestore document ID here
    var datechart = Date()
    
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    

    
    
}


