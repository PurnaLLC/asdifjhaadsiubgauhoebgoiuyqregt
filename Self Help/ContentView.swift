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

    
    @ObservedObject var vm =  OnBoardingControlViewViewModel()
    
    
    var body: some View {
        Group {
            if viewModel.currentUser != nil {
                
                Home()
                .background(HelperView())   // << here !!
            } else {
             
                OnBoardingControlView(usergender: vm.userName, username: vm.userGender)
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

