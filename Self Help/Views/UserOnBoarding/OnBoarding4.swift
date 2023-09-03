//
//  OnBoarding4.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/2/23.
//

import SwiftUI

struct OnBoarding4: View {
    var body: some View {
        
        NavigationView{
            VStack{
                Text("How do you deal with negative thoughts")
                
                
                NavigationLink {
                    
                    OnBoarding5()
                        .navigationBarBackButtonHidden(true)
                    
                }label: {
                    OnBoardingNextButton()
                }
                
                
            }
        }
    }
}
