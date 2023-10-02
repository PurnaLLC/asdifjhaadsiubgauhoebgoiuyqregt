//
//  MessagesModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/26/23.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import FirebaseFirestore



struct FirebaseMessage: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var role = ""
    var content = ""
    var createdAt = Date()
    var userId = ""
    var documentId: String? // Store the Firestore document ID here

    

}
