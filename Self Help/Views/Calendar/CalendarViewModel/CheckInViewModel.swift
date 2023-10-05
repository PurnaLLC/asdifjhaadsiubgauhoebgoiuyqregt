//
//  CheckInViewModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/4/23.
//

import Foundation
import Combine
import FirebaseAuth

// ViewModel
class CheckInViewModel: ObservableObject {
    @Published private(set) var checkins: [CheckIn] = []

    
    
    private let ds: any DataService
    private var cancellables = Set<AnyCancellable>()
    
    init(ds: any DataService = FirebaseDataService()) {
        self.ds = ds
        
        
        
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { checkins in
                self.checkins = checkins.sorted(by: { $0.date < $1.date }) // Sort checkins by date in descending order
            }
            .store(in: &cancellables)
        
        
        
    }

    func formattedDate(date: Date) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "EEEE"
           return dateFormatter.string(from: date)
       }
    
    func add(checkin: CheckIn) {
        ds.add(checkin)
    }
    func update(checkin: CheckIn) {
        ds.update(checkin)
    }
    func delete(checkin: CheckIn) {
            ds.delete(checkin)
    }
    
    func getLast7DaysCheckins() -> [CheckIn] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Use a filter to get Checkins from the last 7 days
        let last7DaysCheckins = checkins.filter { checkin in
            if let checkinDate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: checkin.date) {
                let daysAgo = calendar.dateComponents([.day], from: checkinDate, to: currentDate)
                return daysAgo.day ?? 0 <= 7
            }
            return false
        }
        
        return last7DaysCheckins
    }
    
    
    
}

