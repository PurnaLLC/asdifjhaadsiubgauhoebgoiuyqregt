import Foundation
import SwiftUI

struct DataOfTheDay {
    let date: String
    var greeting1: String?
    var greeting2: String?

    
    
    init(date: String, greeting1: String? = nil, greeting2: String? = nil) {
        self.date = date
        self.greeting1 = greeting1
        self.greeting2 = greeting2
    }
}


 func currentDateFormat(from currentDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM d"
    return formatter.string(from: currentDate)
}

func convertDateFormat(from date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE"
    return formatter.string(from: date)
}

func fetchDataOfTheDay(completion: @escaping (DataOfTheDay?) -> Void) {
    // Define the dictionary mapping each day to data
    let dataOfTheDayMapping: [String: [String: Any]] = [
        "Monday": [
            "greeting1": "SOME BS 1M",
            
            "greeting2": "SOME BS 2M"
            
        ],
        
        "Tuesday": [
            "greeting1": "SOME BS 1T",
            
            "greeting2": "SOME BS 2T"
            
            
        ],
        
        "Wednesday": [
            "greeting1": "SOME BS 1W",
            
            "greeting2": "SOME BS 2W"
            
        ],
        "Thursday": [
            "greeting1": "SOME BS 1Th",
            
            "greeting2": "SOME BS 2Th"
            
        ],
        "Friday": [
            "greeting1": "SOME BS 1F",
            
            "greeting2": "SOME BS 2F"
        ],
        "Saturday": [
            "greeting1": "SOME BS 1Sa",
            
            "greeting2": "SOME BS 2Sa"
        ],
        "Sunday": [
            "greeting1": "SOME BS 1Su",
            
            "greeting2": "SOME BS 2Su"
        ],
      
        
        
        
        
        
        
        // Add more entries for other days
        
    ]
    
    let currentDate = convertDateFormat(from: Date())
    
    // Retrieve the data of the day based on the current date
    guard let fetchedData = dataOfTheDayMapping[currentDate],
          let fetchedGreeting1 = fetchedData["greeting1"] as? String else {
        completion(nil) // Call the completion handler with nil to indicate failure
        return
    }
        let fetchedGreeting2 = fetchedData["greeting2"] as? String
    
    
    
    
    
    // Create a DataOfTheDay instance
    let dataOfTheDayInstance = DataOfTheDay(date: currentDate,  greeting1: fetchedGreeting1, greeting2: fetchedGreeting2)
    completion(dataOfTheDayInstance) // Call the completion handler with the fetched instance
    
    
    
    
}



