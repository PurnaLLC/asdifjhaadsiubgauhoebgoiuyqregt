import Foundation
import SwiftUI

struct DataOfTheDay {
    let date: String
    let affirmation: String
    var challenge: String?
    var greeting: String?
    
    init(date: String, affirmation: String, challenge: String? = nil, greeting: String? = nil) {
        self.date = date
        self.affirmation = affirmation
        self.challenge = challenge
        self.greeting = greeting
    }
}


func convertDateFormat(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d"
    return formatter.string(from: date)
}

func fetchDataOfTheDay(completion: @escaping (DataOfTheDay?) -> Void) {
    // Define the dictionary mapping each day to data
    let dataOfTheDayMapping: [String: [String: Any]] = [
        "September 18": [
            "affirmation": "Ameilia keen loves me",
            "challenge": "talk to a girl",
            "greeting": "tell me about your day virgin boy"
        ],
        // Add more entries for other days
    ]
    
    let currentDate = convertDateFormat(from: Date())
    
    // Retrieve the data of the day based on the current date
    guard let fetchedData = dataOfTheDayMapping[currentDate],
          let fetchedAffirmation = fetchedData["affirmation"] as? String else {
        completion(nil) // Call the completion handler with nil to indicate failure
        return
    }
    
    let fetchedChallenge = fetchedData["challenge"] as? String
    let fetchedGreeting = fetchedData["greeting"] as? String
    
    // Create a DataOfTheDay instance
    let dataOfTheDayInstance = DataOfTheDay(date: currentDate, affirmation: fetchedAffirmation, challenge: fetchedChallenge, greeting: fetchedGreeting)
    completion(dataOfTheDayInstance) // Call the completion handler with the fetched instance
}
