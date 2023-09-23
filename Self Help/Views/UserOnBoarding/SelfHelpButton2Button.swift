//
//  SelfHelpButton2Button.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/19/23.
//

import SwiftUI

struct SelfHelpButton2Button: View {
    
    
    
    @ObservedObject var vm:  OnBoardingControlViewViewModel

    
    var mentalhealthproblem1: String
    var mentalhealthproblemindex: Int
    
    
    @State private var isSelected = false
  
    var body: some View {
        Button {
                 if !vm.selectedProblems.contains(mentalhealthproblem1) {
                     vm.selectedProblems.append(mentalhealthproblem1)
                 } else {
                     vm.selectedProblems.removeAll { $0 == mentalhealthproblem1 }
                 }

                vm.isShowingContinueButton = true
            isSelected.toggle()
            
            print(vm.selectedProblems)
            
            
             } label: {
            Text(mentalhealthproblem1)
                .foregroundColor(isSelected ? .red : .black)
            
        }
    }
}
