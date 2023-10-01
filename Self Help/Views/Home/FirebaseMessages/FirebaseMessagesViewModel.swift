//
//  FirebaseMessagesViewModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/26/23.
//

import Foundation
import Combine
// ViewModel
class FirebaseMessagesViewModel: ObservableObject {
    @Published private(set) var firebaseMessages: [FirebaseMessage] = []

    
    
    private let ds: any MessageDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(ds: any MessageDataService = FirebaseMessageDataService()) {
        self.ds = ds
        ds.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { firebaseMessages in
                self.firebaseMessages = firebaseMessages.sorted(by: { $0.createdAt < $1.createdAt }) // Sort checkins by
            }
            .store(in: &cancellables)
        
        
        
    }

    
    func add(firebasemessage: FirebaseMessage) {
        ds.add(firebasemessage)
    }
    
    
}

