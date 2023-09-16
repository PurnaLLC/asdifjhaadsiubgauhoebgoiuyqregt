//
//  OnBoarding1.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/31/23.
//

import SwiftUI
import Combine

class OnBoarding1VM: ObservableObject {
    @Published var username: String = ""
   
}

struct OnBoarding1: View {
    @StateObject private var vm = OnBoarding1VM()
    @State private var isShowingFinishedButton: Bool = false
    
    var body: some View {
        NavigationView{
            
            ZStack{
            Video()
            
            
            
                VStack {
                    VStack {
                        Text("What should daddy call you")
                        
                        InputView(text: $vm.username,
                                  title: " ",
                                  placeholder: "Name/Nick Name")
                        
                        .frame(width: 300)
                        .onReceive(
                            vm.$username
                                .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                        ) { newText in
                            if !newText.isEmpty {
                                print(">> searchin g for: \(newText)")
                                isShowingFinishedButton = true
                            } else {
                                
                                isShowingFinishedButton = false
                            }
                        }
                        
                        
                        
                        if isShowingFinishedButton {
                            VStack {
                                NavigationLink {
                                    // destination view to navigation to
                                    OnBoarding1Gender(username: vm.username)
                                        .navigationBarBackButtonHidden(true)
                                    
                                }  label: {
                                    OnBoardingNextButton()
                                }
                                
                                
                                
                            }
                            
                        }
                    }
                }
            }
        }
    }
}


struct OnBoarding1_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding1()
    }
}
