//
//  CalendarView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/20/23.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var streak: Int = 0
    @State private var lastCheckedDate: Date?

    var body: some View {
        VStack {
            Text("Daily Streak: \(streak)")
                .font(.title)
                .padding()

            Button(action: {
                performCheckIn()
            }) {
                Text("Mood Check-in")
            }
        }
        .onAppear {
            loadStreak()
        }
    }

    private func performCheckIn() {
        let currentDate = Date()
        
        // Check if there's a last checked date
        if let lastDate = lastCheckedDate {
            let calendar = Calendar.current
            if calendar.isDateInToday(lastDate) {
                // Already checked in today
                return
            }
            
            if calendar.isDateInYesterday(lastDate) {
                // Checked in yesterday, increment the streak
                streak += 1
            } else {
                // Missed a day, reset streak
                streak = 1
            }
        } else {
            // First time check-in
            streak = 1
        }

        // Save the current date
        lastCheckedDate = currentDate
        saveStreak()
    }
    
    //Note change to firebase 
    private func saveStreak() {
        UserDefaults.standard.setValue(streak, forKey: "streak")
        UserDefaults.standard.setValue(lastCheckedDate, forKey: "lastCheckedDate")
    }

    private func loadStreak() {
        streak = UserDefaults.standard.integer(forKey: "streak")
        lastCheckedDate = UserDefaults.standard.object(forKey: "lastCheckedDate") as? Date
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
