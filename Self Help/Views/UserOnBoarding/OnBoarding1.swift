//
//  OnBoarding1.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/31/23.
//

import SwiftUI
import Combine



struct OnBoarding1: View {
    @ObservedObject var vm:  OnBoardingControlViewViewModel
    
    
    @Binding var isShowingFinishedButton: Bool
    
    
    var nextViewAction: () -> Void
    
    var body: some View {
        
        VStack {
            VStack {
                Text("What should daddy call you")
                    .foregroundColor(.white)
                
                
                WhiteInputView(text: $vm.userName,
                          title: " ",
                          placeholder: "Name/Nick Name"
                )
                
                
                .frame(width: 300)
                .onReceive(
                    vm.$userName
                        .debounce(for: .seconds(0.75), scheduler: DispatchQueue.main)
                ) { newText in
                    if !newText.isEmpty {
                        print(">> searchin g for: \(newText)")
                        isShowingFinishedButton = true
                    } else {
                        
                        isShowingFinishedButton = false
                    }
                }
                
            }
        }
    }
}

