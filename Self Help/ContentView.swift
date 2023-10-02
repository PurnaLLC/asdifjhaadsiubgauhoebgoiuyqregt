//
//  ContentView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/20/23.
//

import SwiftUI


struct ContentsView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var animationDuration: Double = 3
    @State private var isMinimized: Bool = true
    @State private var numberOfPetals: Double = 7

    let getUserDataTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    var body: some View {
        Group {
            if viewModel.currentUser != nil {
             //   FlowerView(isMinimized: $isMinimized, numberOfPetals: $numberOfPetals, animationDuration: $animationDuration)
                
            Home()
                
        
            } else {
              //  OnBoarding1()
               //    .background(HelperView())   // << here !!
//                FlowerView(isMinimized: .constant(false),
//                           numberOfPetals: .constant(5),
//                           animationDuration: .constant(4.2))
                //           getSwifty()
                
                OnBoardingControlView(usergender: "", username: "")
            }
        }
      
    }
}



//currentUser
//userSession

struct ContentsView_Previews: PreviewProvider {
        static var previews: some View {
            ContentsView().environmentObject(AuthViewModel())
        }
    }

