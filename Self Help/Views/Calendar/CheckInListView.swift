//
//  UserListView.swift
//  DataService
//
//  Created by Tim Yoon on 6/11/23.
//
//  SwiftUI
//  Decouple peristence (DataService) from ViewModel
//  Combine framework and Dependency Injection
//  MVVM Example
//
//  MockDataService and UserDefaultDataService
//  Could be easily extended to Firebase Firestore or CoreData


import SwiftUI
import Combine
import Charts

struct CheckInListView: View {
    @ObservedObject var vm: CheckInViewModel
    @State private var isShowingSheet = false
    
    @State private var streak: Int = 0
    @State private var lastCheckedDate: Date?
    
    
    var body: some View {
        
        VStack{
            
            Chart{
                ForEach(vm.checkins){checkin in
                    BarMark(x:.value("Day", checkin.date, unit: .day),
                             y: .value("Rating", checkin.day1to10))
                    
                }
            }.frame(width: 375, height: 180)
            
            
            VStack {
                Text("Daily Streak: \(streak)")
                    .font(.title)
                    .padding()
               
            }
            
            .onAppear {
                loadStreak()
                print("Loaded streak: \(streak)")
                print("Last checked date: \(String(describing: lastCheckedDate))")
            }
            
            
            
            NavigationStack {
                List {
                    ForEach(vm.checkins.reversed()) { checkin in // Reverse the array here
                        NavigationLink {
                            CheckInEditView(checkin: checkin) { returnedCheckIn in
                                vm.update(checkin: returnedCheckIn)
                            }
                        } label: {
                            
                            HStack{
                                Text("Date: \(checkin.formattedDate())")
                                Text("\(checkin.day1to10)")
                                
                                
                            }
                        }
                        
                    }
                    .onDelete(perform: vm.delete)
                }
                .navigationTitle("Check Ins")
                .toolbar {
                    Button {
                        
                        
                        isShowingSheet = true
                        
                        
                    } label: {
                        Text("Add")
                    }
                    
                }
                .sheet(isPresented: $isShowingSheet) {
                    NavigationStack {
                        CheckInEditView(checkin: CheckIn()) { returnedCheckIn in
                            vm.add(checkin: returnedCheckIn)
                        }
                        .navigationTitle("Add Checkin")
                    }
                }
            }
        }
    }
    
    private func performCheckIn() {
        let currentDate = Date()
        
        // Check if there's a last checked date
        if let lastDate = lastCheckedDate {
            let calendar = Calendar.current
            
            // Compare date components, excluding time
            if calendar.isDateInToday(lastDate) {
                // Already checked in today
                return
            }
            
            if calendar.isDateInYesterday(lastDate) {
                // Checked in yesterday, increment the streak
                streak += 1
            } else {
                // Missed a day, reset streak
                streak = 0
            }
        } else {
            // First time check-in
            streak = 1
        }
        // Save the current date
        lastCheckedDate = currentDate
        saveStreak()
    }
    private func saveStreak() {
        UserDefaults.standard.setValue(streak, forKey: "streak")
        UserDefaults.standard.setValue(lastCheckedDate, forKey: "lastCheckedDate")
    }
    private func loadStreak() {
        streak = UserDefaults.standard.integer(forKey: "streak")
        lastCheckedDate = UserDefaults.standard.object(forKey: "lastCheckedDate") as? Date
    }
}


