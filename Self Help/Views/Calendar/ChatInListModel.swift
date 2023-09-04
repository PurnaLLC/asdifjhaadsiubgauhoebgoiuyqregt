//
//  ChatInListModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/3/23.
//

import Foundation


struct CheckIn: Identifiable, Codable {
    var id = UUID()
    var date = Date()
    var name = ""
    var day1to10 = 0
    
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }

    
}
