//
//  BreathAnimationCategoryView.swift
//  BreathingAnimation
//
//  Created by Maxwell Meyer on 9/25/23.
//  Copyright © 2023 CodingBytes. All rights reserved.
//

import SwiftUI

struct BreathAnimationCategoryView: View {
    
    
    @State  var title: String
    
    
    @State  var description: String

    
    
    
    var body: some View {
        
        
        VStack(alignment: .leading){
            Text(title)
                .foregroundColor(.black)
            HStack{
                Text(description)
                    .foregroundColor(.black)
                
                FlowerView(isMinimized: .constant(false),
                                numberOfPetals: .constant(7),
                           animationDuration: .constant(4.2), circleDiameter: 25
                )
                .padding()
                .frame(maxWidth: 120, alignment: .trailing)

                
            }
            .padding(.top, -10)
            .padding(.bottom, -10)
        
            .background(Color.gray) // Set the background color to gray
            .cornerRadius(10)
            
        }
  
        
             
             
             
        
        
        
    }
}

struct BreathAnimationCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        BreathAnimationCategoryView(title: "relaxora", description: "penis ara ara ara ara ara ara")
    }
}

