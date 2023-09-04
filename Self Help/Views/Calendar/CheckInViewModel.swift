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
