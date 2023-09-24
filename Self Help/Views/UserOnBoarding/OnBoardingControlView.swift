//
//  OnBoardingControlView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/15/23.
//

import SwiftUI

enum OnboardingNavigation {
    case onBoarding1
    case onBoarding1Gender
    case onBoarding2
    case shame
    case anger
    case guilt
    case anxiety
    case fear
    case depression
    case onBoarding3
    case onBoarding4
    case onBoarding5
    case onBoarding6
}



class OnBoardingControlViewViewModel: ObservableObject {
    
    
    @Published var userName: String = ""
    @Published var userGender: String = ""
    @Published var isShowingContinueButton: Bool = false
    @Published var selectedProblems: [String] = []
    
    
    
}


struct OnBoardingControlView: View {
    @State private var currentView: OnboardingNavigation = .onBoarding1
    
    
    
    
    
    // @ObservedObject var vmo =
    
    
    
    @StateObject var vm = OnBoardingControlViewViewModel()
    
    
    @State private var isShowingFinishedButton = false
    
    @State private var isShowingFinishedButton2 = false
    
    
    
    
    @State var usergender: String
    @State var username: String
    
    
    
    @State private var showShameView = false
    @State private var showAngerView = false
    @State private var showGuiltView = false
    @State private var showAnxietyView = false
    @State private var showFearView = false
    @State private var showDepressionView = false
    
    
    
    @State private var showButton = true
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Video()
                    .ignoresSafeArea()
                
                VStack {
                    // Display the appropriate view based on the currentView state
                    switch currentView {
                    case .onBoarding1:
                        OnBoarding1(vm: vm, isShowingFinishedButton: $isShowingFinishedButton, nextViewAction: { currentView = .onBoarding1 })
                    case .onBoarding1Gender:
                        OnBoarding1Gender(vm: vm, username: vm.userName, isShowingFinishedButton: $isShowingFinishedButton2, nextViewAction: { currentView = .onBoarding1Gender })
                    case .onBoarding2:
                        OnBoarding2(usergender: vm.userGender , username: vm.userName, vm: vm )
                        
                        
                    case .shame:
                        Shame(vm: vm, selectedProblems: vm.selectedProblems)
                        
                        
                    case .anger:
                        
                        Anger(vm: vm, selectedProblems: vm.selectedProblems)
                    case .guilt:
                        Guilt(vm: vm, selectedProblems: vm.selectedProblems)
                    case .anxiety:
                        Anxiety(vm: vm, selectedProblems: vm.selectedProblems)
                    case .fear:
                        Fear(vm: vm, selectedProblems: vm.selectedProblems)
                        
                    case .depression:
                        
                        Depression(vm: vm, selectedProblems: vm.selectedProblems)
                        
                    case .onBoarding3:
                        
                        OnBoarding3()
                        
                    case .onBoarding4:
                        OnBoarding4()
                        
                    case .onBoarding5:
                        
                        OnBoarding5()
                    case .onBoarding6:
                        OnBoarding6()
                    
                        
                    }

                   
                    HStack {
                
                        
                        
                        
                        if currentView == .onBoarding1 {
                            
                            if isShowingFinishedButton == true{
                                Button("Next") {
                                    currentView = .onBoarding1Gender
                                    
                                }
                                
                            }
                        } else if currentView == .onBoarding1Gender {
                            
                            
                            
                            if isShowingFinishedButton2 == true{
                                Button("Next") {
                                    currentView = .onBoarding2
                                    
                                }
                                
                            }
                            
                        } else if currentView == .onBoarding2 {
                            
                            
                            if vm.isShowingContinueButton {
                                
                                Button("Next") {
                                    if vm.selectedProblems.contains("Shame"){
                                        
                                        currentView = .shame
                                    }else{
                                        
                                        
                                        
                                        if vm.selectedProblems.contains("Anger"){
                                            
                                            currentView = .anger
                                        }else{
                                            
                                            
                                            if vm.selectedProblems.contains("Guilt"){
                                                
                                                currentView = .guilt
                                                
                                            }else{
                                                
                                                
                                                if vm.selectedProblems.contains("Anxiety"){
                                                    
                                                    currentView = .anxiety
                                                }else{
                                                    
                                                    
                                                    if vm.selectedProblems.contains("Fear"){
                                                        currentView = .fear
                                                        
                                                    }else{
                                                        if vm.selectedProblems.contains("Depression"){
                                                            
                                                            currentView = .depression
                                                        }else{
                                                            
                                                            currentView = .onBoarding3
                                                        }
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                
                                                
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }else if currentView == .shame {
                            
                            Button("Next") {
                                
                                
                                
                                if vm.selectedProblems.contains("Anger"){
                                    
                                    currentView = .anger
                                }else{
                                    
                                    
                                    if vm.selectedProblems.contains("Guilt"){
                                        
                                        currentView = .guilt
                                        
                                    }else{
                                        
                                        
                                        if vm.selectedProblems.contains("Anxiety"){
                                            
                                            currentView = .anxiety
                                        }else{
                                            
                                            
                                            if vm.selectedProblems.contains("Fear"){
                                                currentView = .fear
                                                
                                            }else{
                                                if vm.selectedProblems.contains("Depression"){
                                                    
                                                    currentView = .depression
                                                }else{
                                                    
                                                    currentView = .onBoarding3
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                }
                                
                                
                                
                                
                            }
                            
                        }else if currentView == .anger {
                            
                            Button("Next") {
                                
                                
                                
                                
                                if vm.selectedProblems.contains("Guilt"){
                                    
                                    currentView = .guilt
                                    
                                }else{
                                    
                                    
                                    if vm.selectedProblems.contains("Anxiety"){
                                        
                                        currentView = .anxiety
                                    }else{
                                        
                                        
                                        if vm.selectedProblems.contains("Fear"){
                                            currentView = .fear
                                            
                                        }else{
                                            if vm.selectedProblems.contains("Depression"){
                                                
                                                currentView = .depression
                                            }else{
                                                
                                                currentView = .onBoarding3
                                            }
                                            
                                            
                                        }
                                        
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                            
                        }else if currentView == .guilt{
                            
                            
                            Button("Next") {
                                
                                
                                
                                
                                if vm.selectedProblems.contains("Anxiety"){
                                    
                                    currentView = .anxiety
                                }else{
                                    
                                    
                                    if vm.selectedProblems.contains("Fear"){
                                        currentView = .fear
                                        
                                    }else{
                                        if vm.selectedProblems.contains("Depression"){
                                            
                                            currentView = .depression
                                        }else{
                                            
                                            currentView = .onBoarding3
                                        }
                                        
                                        
                                    }
                                    
                                }
                            }
                            
                            
                        }else if currentView == .anxiety{
                            
                            Button("Next") {
                                
                                if vm.selectedProblems.contains("Fear"){
                                    currentView = .fear
                                    
                                }else{
                                    if vm.selectedProblems.contains("Depression"){
                                        
                                        currentView = .depression
                                    }else{
                                        
                                        currentView = .onBoarding3
                                    }
                                    
                                    
                                }
                            }
                        }else if currentView == .fear{
                            Button("Next") {
                                if vm.selectedProblems.contains("Depression"){
                                    
                                    currentView = .depression
                                }else{
                                    
                                    currentView = .onBoarding3
                                }
                            }
                            
                        }else if currentView == .depression{
                            
                            Button("Next") {
                                currentView = .onBoarding3
                                
                            }
                            
                            
                        }else if currentView == .onBoarding3{
                            Button("Next") {
                                currentView = .onBoarding4
                                
                            }
                            
                            
                        }else if currentView == .onBoarding4{
                            Button("Next") {
                                currentView = .onBoarding5
                                
                            }
                            
                            
                        }else if currentView == .onBoarding5{
                            Button("Next") {
                                currentView = .onBoarding6
                                
                            }
                            
                            
                        }else if currentView == .onBoarding6{
                            
                            
                            
                            NavigationLink(destination: LoginView()) {
                                Text("Next")
                            }
                            .navigationBarHidden(true)
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                    }
                    .padding()
                }
            }
        }
    }
}




