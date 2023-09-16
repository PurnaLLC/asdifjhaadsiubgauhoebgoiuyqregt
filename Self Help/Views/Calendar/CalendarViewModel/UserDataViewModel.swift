//
//  UserDataViewModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/9/23.
//

import Foundation
import Combine
import FirebaseAuth


// ViewModel
class UserDataViewModel: ObservableObject {
    @Published private(set) var userData: UserData
    
    private let ds: any UserDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(ds: any UserDataService = UserFirebaseDataService()) {
        self.ds = ds
        self.userData = UserData() // Initialize userData with default values
        
        ds.get()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] userDatas in
                    // Assuming you want the first user data in the array
                    if let firstUserData = userDatas.first {
                        self?.userData = firstUserData
                    }
                  })
            .store(in: &cancellables)
    }
    
    func updateUserData(_ userData: UserData) {
        ds.update(userData)
    }
    
    // Other methods for managing UserData
    
    func updateStreak(_ newStreak: Int) {
           // Modify the streak property of userData
           self.userData.streak = newStreak
           // You can also update the user data on your data service here if needed
           ds.update(self.userData)
        ds.update(userData)
        }
    
    
    
    
}
