//
//  Anger.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/1/23.
//

import SwiftUI

struct Anger: View {
    @ObservedObject var vm: OnBoardingControlViewViewModel
    
    @State var selectedProblems: [String]
    

    var body: some View {

            VStack{
                Text("What type of Anger")
                
                SelfHelpButton2Button(vm: vm, mentalhealthproblem1: "Option1",  mentalhealthproblemindex: 0)
                SelfHelpButton2Button(vm: vm, mentalhealthproblem1: "Opntion2", mentalhealthproblemindex: 1)
                SelfHelpButton2Button(vm: vm, mentalhealthproblem1: "Opntion3", mentalhealthproblemindex: 2)
                SelfHelpButton2Button(vm: vm, mentalhealthproblem1: "Opntion4", mentalhealthproblemindex: 3)
                SelfHelpButton2Button(vm: vm, mentalhealthproblem1: "Opntion5", mentalhealthproblemindex: 4)
                SelfHelpButton2Button(vm: vm, mentalhealthproblem1: "Opntion6", mentalhealthproblemindex: 5)
                
                
            }
        }
    
}

