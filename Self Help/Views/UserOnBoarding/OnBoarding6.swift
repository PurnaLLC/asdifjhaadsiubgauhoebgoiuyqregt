//
//  OnBoarding6.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/2/23.
//

import SwiftUI

struct OnBoarding6: View {
    var body: some View {
        NavigationView{
            
            Text("When would you like noties")
            NavigationLink {
                
                LoginView()
                    .navigationBarBackButtonHidden(true)
                
            }label: {
                Text("Jack is sus")
            }
            
        }
    }
}

struct OnBoarding6_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding6()
    }
}
