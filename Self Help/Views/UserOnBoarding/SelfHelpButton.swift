//
//  SelfHelpButton.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/1/23.
//

import SwiftUI

struct SelfHelpButton: View{
    
    
    @ObservedObject var vm:  OnBoardingControlViewViewModel

    
    let mentalhealthproblem1: String
    
    let action: () -> Void
    
    @State private var isSelected = false

    var body: some View {
        Button(action: {
            action() // Call the provided action closure
            
            // The rest of your button's logic
            if !isSelected {
                // Toggle the selection
                vm.selectedProblems.append(mentalhealthproblem1)
            } else {
                vm.selectedProblems.removeAll { $0 == mentalhealthproblem1 }
            }
            
            vm.isShowingContinueButton = true
            isSelected.toggle()
            
            
            
            print(vm.selectedProblems)
        }) {
            Text(mentalhealthproblem1)
                .foregroundColor(isSelected ? .red : .black)
        }
    }
}
