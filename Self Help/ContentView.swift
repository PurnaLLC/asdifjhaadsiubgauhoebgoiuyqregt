//
//  ContentView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/20/23.
//

import SwiftUI


struct ContentsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    let getUserDataTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Group {
            if viewModel.currentUser != nil {
                Home()
                    .background(HelperView())   // << here !!
            } else {
              //  OnBoarding1()
               //    .background(HelperView())   // << here !!
                
                OnBoarding1()
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

