//
//  SelfHelpButton.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/1/23.
//

import SwiftUI

struct SelfHelpButton: View{
    
    var mentalhealthproblem1: String
    var mentalhealthproblemindex: Int
    @ObservedObject var vm: OnBoarding2ViewModel
    
    @State private var isSelected: Bool = false
    
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
