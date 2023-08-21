//
//  WordOfTheDayModel.swift
//  Wordz


import Foundation
import UIKit

struct DataOfTheDay {
    let date: String
    let affirmation: String
    var challenge: String?
    
    init(date: String, affirmation: String) {
        self.date = date
        self.affirmation = affirmation
    }
}

func fetchDataOfTheDay(completion: @escaping (DataOfTheDay?) -> Void) {
    // Define the dictionary mapping each day to data
    let dataOfTheDayMapping: [String: [String: Any]] = [
        "2023-07-14": [
            "affirmation": "FURBISHING",
            "challenge": "verb",
        ],
        // Add more entries for other days
    ]
    
    // Get the current date
    let currentDate = Date()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let dateString = dateFormatter.string(from: currentDate)
    
    // Retrieve the data of the day based on the current date
    guard let fetchedData = dataOfTheDayMapping[dateString],
          let fetchedAffirmation = fetchedData["affirmation"] as? String,
          let fetchedChallenge = fetchedData["challenge"] as? String else {
        // Handle if the data is not available for the current day
        print("OHHHH CRAPE FROM THE INFORMATION DATA.")
        completion(nil) // Call the completion handler with nil to indicate failure
        return
    }
    
    // Create a DataOfTheDay instance
    var dataOfTheDayInstance = DataOfTheDay(date: dateString, affirmation: fetchedAffirmation)
    dataOfTheDayInstance.challenge = fetchedChallenge
    
    completion(dataOfTheDayInstance) // Call the completion handler with the fetched instance
}
