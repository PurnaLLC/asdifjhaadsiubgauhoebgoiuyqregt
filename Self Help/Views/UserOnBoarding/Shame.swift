//
//  Shame.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/1/23.
//

import SwiftUI

struct Shame: View {
    
    @ObservedObject var vm: OnBoarding2ViewModel
    
    @State var selectedProblems: [String]
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("What type of shame")
                
                
                
                SelfHelpButton(mentalhealthproblem1: "Option1",  mentalhealthproblemindex: 0, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Opntion2", mentalhealthproblemindex: 1, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Opntion3", mentalhealthproblemindex: 2, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Opntion4", mentalhealthproblemindex: 3, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Opntion5", mentalhealthproblemindex: 4, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Opntion6", mentalhealthproblemindex: 5, vm: vm)
                
                
                NavigationLink {
               
                        if vm.selectedProblems.contains("Anger"){
                            
                            Anger(vm: vm, selectedProblems: vm.selectedProblems)
                                .navigationBarBackButtonHidden(true)
                        }else{
                            
                            
                            if vm.selectedProblems.contains("Guilt"){
                                
                                Guilt(vm: vm, selectedProblems: vm.selectedProblems)
                                    .navigationBarBackButtonHidden(true)
                            }else{
                                
                                
                                if vm.selectedProblems.contains("Anxiety"){
                                    
                                    Anxiety(vm: vm, selectedProblems: vm.selectedProblems)
                                        .navigationBarBackButtonHidden(true)
                                }else{
                                    
                                    
                                    if vm.selectedProblems.contains("Fear"){
                                        
                                        Fear(vm: vm, selectedProblems: vm.selectedProblems)
                                            .navigationBarBackButtonHidden(true)
                                    }else{
                                        if vm.selectedProblems.contains("Depression"){
                                            
                                            Depression(vm: vm, selectedProblems: vm.selectedProblems)
                                                .navigationBarBackButtonHidden(true)
                                        }else{
                                            
                                            OnBoarding3() 
                                                .navigationBarBackButtonHidden(true)
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }
                                
                                
                            }
                        }
                } label: {
                    OnBoardingNextButton()
                }
                
                
            }
        }
    }
}


