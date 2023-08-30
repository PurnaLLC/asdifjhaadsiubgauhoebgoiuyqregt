//
//  WordOfTheDayModel.swift
//  Wordz


import Foundation
import SwiftUI




struct DataOfTheDay {
    let date: String
    let affirmation: String
    var challenge: String?
    var greeting: String?
    
    init(date: String, affirmation: String) {
        self.date = date
        self.affirmation = affirmation
    }
}

func fetchDataOfTheDay(completion: @escaping (DataOfTheDay?) -> Void) {
    // Define the dictionary mapping each day to data
    let dataOfTheDayMapping: [String: [String: Any]] = [
        "2023-08-29": [
            "affirmation": "Ameilia keen loves me",
            "challenge": "talk to a girl",
            "greeting": "tell me about your day virgin boy"
            
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
          let fetchedGreeting = fetchedData["greeting"] as? String,
          let fetchedChallenge = fetchedData["challenge"] as? String else {
        // Handle if the data is not available for the current day
        print("OHHHH CRAPE FROM THE INFORMATION DATA.")
        completion(nil) // Call the completion handler with nil to indicate failure
        return
    }
    
    // Create a DataOfTheDay instance
    var dataOfTheDayInstance = DataOfTheDay(date: dateString, affirmation: fetchedAffirmation)
    dataOfTheDayInstance.challenge = fetchedChallenge
    dataOfTheDayInstance.greeting = fetchedGreeting
    completion(dataOfTheDayInstance) // Call the completion handler with the fetched instance
}
