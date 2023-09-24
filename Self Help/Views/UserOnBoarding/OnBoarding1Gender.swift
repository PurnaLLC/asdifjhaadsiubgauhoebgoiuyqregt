//
//  OnBoarding1Gender.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/1/23.
//

import SwiftUI

struct OnBoarding1Gender: View {
    
    @State private var isShowingGender: Bool = false
    @ObservedObject  var vm:  OnBoardingControlViewViewModel
    

    
    @State var username: String
    
    @Binding var isShowingFinishedButton: Bool
    
    var nextViewAction: () -> Void
    
    
    
    var body: some View {

            
           
                VStack {
                    VStack {
                        Text("What Gender are you \(username)")
                        
                        WhiteInputView(text: $vm.userGender,
                                  title: " ",
                                  placeholder: "Name/Nick Name")
                        
                        .frame(width: 300)
                        .onReceive(
                            vm.$userGender
                                .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                        ) { userGender in
                            if !userGender.isEmpty {
                                print(">> searchin g for: \(userGender)")
                                isShowingFinishedButton = true
                            } else {
                                
                                isShowingFinishedButton = false
                            }
                        }
                        
                        
                    }
                }
                .onAppear {
                    // Load the username from UserDefaults when the view appears
                    let defaults = UserDefaults.standard
                    defaults.set(username, forKey: "username")
                }
            }
        
    
}


