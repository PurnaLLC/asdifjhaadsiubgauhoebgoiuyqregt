//
//  User.swift
//  Wordz
//
//  Created by Maxwell Meyer on 6/6/23.
//

import Foundation
import Firebase
import FirebaseStorage


struct User: Identifiable, Codable {
    let id: String
    let fullname: String
    let email: String
    


    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components=formatter.personNameComponents(from: fullname){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return "hello"
    }
    

}

extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "Jack Russel", email:"penisballs@gmail.com")
}

