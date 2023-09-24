//
//  OnBoarding2.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/31/23.
//




import SwiftUI




struct OnBoarding2: View {
    
    
    
    @State var usergender: String
    @State var username: String
    
    
    @ObservedObject var vm: OnBoardingControlViewViewModel
    
    @State private var showShameView = false
    @State private var showAngerView = false
    @State private var showGuiltView = false
    @State private var showAnxietyView = false
    @State private var showFearView = false
    @State private var showDepressionView = false
    
    
    
    
    @State private var showButton = true
    
    
    
    var body: some View {
            
            
            VStack{
                
                Text("What are you going through \(username)")
            
            
                SelfHelpButton(vm: vm, mentalhealthproblem1: "Shame", action: { showShameView = true })
                SelfHelpButton(vm: vm, mentalhealthproblem1: "Anger", action: { showAngerView = true })
                SelfHelpButton(vm: vm, mentalhealthproblem1: "Guilt", action: { showGuiltView = true })
                SelfHelpButton(vm: vm, mentalhealthproblem1: "Anxiety", action: { showAnxietyView = true })
                SelfHelpButton(vm: vm, mentalhealthproblem1: "Fear", action: { showFearView = true })
                SelfHelpButton(vm: vm, mentalhealthproblem1: "Depression", action: { showDepressionView = true })
                
            }
            
            
            
        }
        

    
}

