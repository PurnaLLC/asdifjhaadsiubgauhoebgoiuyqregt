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

func convertDateFormat(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let dateString = formatter.string(from: date)
    
    if let originalDate = formatter.date(from: dateString) {
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: originalDate)
    } else {
        return dateString
    }
}

func fetchDataOfTheDay(completion: @escaping (DataOfTheDay?) -> Void) {
    // Define the dictionary mapping each day to data
    let dataOfTheDayMapping: [String: [String: Any]] = [
        "August 31, 2023": [
            "affirmation": "Ameilia keen loves me",
            "challenge": "talk to a girl",
            "greeting": "tell me about your day virgin boy"
        ],
        // Add more entries for other days
    ]
    
    let currentDate = convertDateFormat(from: Date())
    
    // Retrieve the data of the day based on the current date
    guard let fetchedData = dataOfTheDayMapping[currentDate],
          let fetchedAffirmation = fetchedData["affirmation"] as? String,
          let fetchedGreeting = fetchedData["greeting"] as? String,
          let fetchedChallenge = fetchedData["challenge"] as? String else {
        // Handle if the data is not available for the current day
        print("OHHHH CRAPE FROM THE INFORMATION DATA.")
        completion(nil) // Call the completion handler with nil to indicate failure
        return
    }
    
    // Create a DataOfTheDay instance
    var dataOfTheDayInstance = DataOfTheDay(date: currentDate, affirmation: fetchedAffirmation)
    dataOfTheDayInstance.challenge = fetchedChallenge
    dataOfTheDayInstance.greeting = fetchedGreeting
    completion(dataOfTheDayInstance) // Call the completion handler with the fetched instance
}
