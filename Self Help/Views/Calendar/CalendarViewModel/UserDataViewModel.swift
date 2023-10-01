//
//  UserDataViewModel.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/9/23.
//

import Foundation
import Combine
import FirebaseAuth





class UserDataViewModel: ObservableObject {
    
    @Published private(set)  var userdatas: [UserData] = []
    
    private let dataService: any UserDataService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: any UserDataService) {
           self.dataService = dataService
           
           dataService.get()
            .sink { error in
                fatalError("\(error)")
            } receiveValue: { userdatas in
                self.userdatas = userdatas 
            }
            .store(in: &cancellables)
       }

    
    func increaseStreak(_ userId: String, _ currentStreak : Int) {
        
        dataService.increaseStreak(userId, currentStreak: currentStreak)
        
    }
    
    
    
    func updateStreakDate(_ userId: String, currentDate: Date){
        
        dataService.updateStreakDate(userId, newStreakDate: currentDate)
        
    
    }
    
    
    func resetStreak(_ userId: String){
        
        dataService.resetStreakDate(userId)
        
    }
    
    
    
}
