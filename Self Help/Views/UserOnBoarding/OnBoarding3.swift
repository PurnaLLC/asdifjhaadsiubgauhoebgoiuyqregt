//
//  OnBoarding3.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/1/23.
//

import SwiftUI

struct OnBoarding3: View {
    
    
    
    
    
    //  let savedArray = UserDefaults.standard.object(forKey: "usergender ") as? [String] ?? [String]()
    
    var body: some View {
        NavigationView{
            Text("What is your favorite color!")
            
            
            
            NavigationLink {
                       
                    OnBoarding4()
                        .navigationBarBackButtonHidden(true)
 
            }label: {
                Text("Jack is sus")
            }
            
            
            
        }
        
    }
}

