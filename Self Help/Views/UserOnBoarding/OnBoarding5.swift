//
//  OnBoarding5.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/2/23.
//

import SwiftUI

struct OnBoarding5: View {
    var body: some View {
        
        NavigationView{
            VStack{
                Text("Do you have aids")
                
                NavigationLink {
                    
                    OnBoarding5()
                        .navigationBarBackButtonHidden(true)
                    
                }label: {
                    Text("Jack is sus")
                }
                
            }
        }
    }
}

struct OnBoarding5_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding5()
    }
}
