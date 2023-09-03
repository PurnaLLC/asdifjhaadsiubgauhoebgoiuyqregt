//
//  OnBoarding1Gender.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/1/23.
//

import SwiftUI

class OnBoarding1GenderVM: ObservableObject {
 
    @Published var userGender: String = ""
}
struct OnBoarding1Gender: View {
    
    @State private var isShowingGender: Bool = false
    @StateObject private var vm = OnBoarding1GenderVM()
    
    @StateObject private var vm2 = OnBoarding1VM()
    
    @State var username: String
    
    @State private var isShowingFinishedButton: Bool = false
    
    var body: some View {
        NavigationView{
            VStack {
                VStack {
                    Text("What Gender are you \(username)")
                    
                    InputView(text: $vm.userGender,
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
                    
                  
                    
                    if isShowingFinishedButton {
                        VStack {
                            NavigationLink {
                                // destination view to navigation to
                                OnBoarding2(usergender: vm.userGender, username: vm2.username)
                                    .navigationBarBackButtonHidden(true)
                            }  label: {
                                OnBoardingNextButton()
                            }
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
}


