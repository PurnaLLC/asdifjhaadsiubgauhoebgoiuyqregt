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



// ViewModel
class CheckInViewModel: ObservableObject {
    @Published private(set) var checkins: [CheckIn] = []
    
    private let ds: any DataService
    private var cancellables = Set<AnyCancellable>()
    
    init(ds: any DataService = UserDefaultDataService()) {
        self.ds = ds
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { checkins in
                self.checkins = checkins
            }
            .store(in: &cancellables)
    }
    
    func add(checkin: CheckIn) {
        ds.add(checkin)
    }
    func update(checkin: CheckIn) {
        ds.update(checkin)
    }
    func delete(indexSet: IndexSet) {
        ds.delete(indexSet: indexSet)
    }
}

struct CheckInEditView: View {
    @State var checkin: CheckIn
    var save: (CheckIn)->()
    @Environment(\.dismiss) var dismiss
    

    var body: some View {
        
        
        HStack {
            

            VStack{
               
                
                
                Text("Integer Value: \(checkin.day1to10)")
                
                Stepper(value: $checkin.day1to10, in: 0...10, step: 1) {
                    Text("Increment")
                    
                    Text("Date: \(checkin.formattedDate())")
                    
                    TextField("Description of day", text: $checkin.name)
                        .textFieldStyle(.roundedBorder)
                }
                
            }
            Button {
                save(checkin)
                dismiss()
            } label: {
                Text("Save")
            }

        }
       
        
        .padding()
    }
}

struct CheckInListView: View {
    @ObservedObject var vm: CheckInViewModel
    @State private var isShowingSheet = false
    
    @State private var streak: Int = 0
    @State private var lastCheckedDate: Date?
    
    
    var body: some View {
        
        VStack{
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



protocol DataService: ObservableObject {
    func get() -> AnyPublisher<[CheckIn], Error>
    func add(_ checkin: CheckIn)
    func update(_ checkin: CheckIn)
    func delete(indexSet: IndexSet)
}

class MockDataService: DataService {
    @Published private var checkins: [CheckIn] = []
    
    func get() -> AnyPublisher<[CheckIn], Error> {
        $checkins.tryMap({$0}).eraseToAnyPublisher()
    }
    
    func add(_ checkin: CheckIn) {
        checkins.append(checkin)
    }
    
    func update(_ checkin: CheckIn) {
        guard let index = checkins.firstIndex(where: {$0.id == checkin.id}) else { return }
        checkins[index] = checkin
    }
    
    func delete(indexSet: IndexSet) {
        checkins.remove(atOffsets: indexSet)
    }
}

class UserDefaultDataService: DataService {
    @Published private var checkins: [CheckIn] {
        didSet {
            save(items: checkins, key: key)
        }
    }
    
    private var key = "UserDefaultDataService"
    init(){
        checkins = []
        checkins = load(key: key)
    }
    func get() -> AnyPublisher<[CheckIn], Error> {
        $checkins.tryMap({$0}).eraseToAnyPublisher()
    }
    
    func add(_ item: CheckIn) {
        checkins.append(item)
    }
    
    func update(_ item: CheckIn) {
        guard let index = checkins.firstIndex(where: {$0.id == item.id}) else { return }
        checkins[index] = item
    }
    
    func delete(indexSet: IndexSet) {
        checkins.remove(atOffsets: indexSet)
    }
    
    // MARK: Private
    func save<T: Identifiable & Codable> (items: [T], key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode (items) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: key)
        }
    }
    func load<T: Identifiable & Codable> (key: String) -> [T] {
        guard let data = UserDefaults.standard.object (forKey: key) as? Data else {return [] }
        let decoder = JSONDecoder()
        if let dataArray = try? decoder.decode ([T].self, from: data) {
            return dataArray
        }
        return []
    }
    
}


