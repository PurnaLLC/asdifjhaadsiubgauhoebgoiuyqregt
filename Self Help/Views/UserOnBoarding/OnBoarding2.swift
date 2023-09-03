//
//  OnBoarding2.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/31/23.
//




import SwiftUI


class OnBoarding2ViewModel: ObservableObject {
    @Published var isShowingContinueButton: Bool = false
    @Published var selectedProblems: [String] = []

    
}


struct OnBoarding2: View {
    @State var usergender: String
    @State var username: String
    @ObservedObject var vm = OnBoarding2ViewModel()
    

    
    var body: some View {
        NavigationView{
            VStack{
           
                Text("What are you going through \(username)")
                
                SelfHelpButton(mentalhealthproblem1: "Shame",  mentalhealthproblemindex: 0, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Anger", mentalhealthproblemindex: 1, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Guilt", mentalhealthproblemindex: 2, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Anxiety", mentalhealthproblemindex: 3, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Fear", mentalhealthproblemindex: 4, vm: vm)
                SelfHelpButton(mentalhealthproblem1: "Depression", mentalhealthproblemindex: 5, vm: vm)
                
                
                
             
                if vm.isShowingContinueButton {
                    NavigationLink {
                        switch vm.selectedProblems.first {
                        case "Shame":
                            Shame(vm: vm, selectedProblems: vm.selectedProblems)
                                .navigationBarBackButtonHidden(true)
                        case "Anger":
                            Anger(vm: vm, selectedProblems: vm.selectedProblems)
                                .navigationBarBackButtonHidden(true)
                        case "Guilt":
                            Guilt(vm: vm, selectedProblems: vm.selectedProblems)
                                .navigationBarBackButtonHidden(true)
                        case "Anxiety":
                            Anxiety(vm: vm, selectedProblems: vm.selectedProblems)
                                .navigationBarBackButtonHidden(true)
                        case "Fear":
                            Fear(vm: vm, selectedProblems: vm.selectedProblems)
                                .navigationBarBackButtonHidden(true)
                        default:
                            Depression(vm: vm, selectedProblems: vm.selectedProblems)
                                .navigationBarBackButtonHidden(true)
                        }
                      
                    } label: {
                       OnBoardingNextButton()

                    }
                }

        
            }
            .onAppear{
                if let savedUsergender = UserDefaults.standard.string(forKey: "usergender") {
                    self.usergender = savedUsergender
                }
                print("max look here")
               
                
            }
            
            
        }
                
    }
    
    
    
    

    
}
