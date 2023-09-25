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
                .foregroundColor(.white)
            HStack{
                Text(description)
                    .foregroundColor(.black)
                
                SmallFlowerView(isMinimized: .constant(false),
                                numberOfPetals: .constant(7),
                                animationDuration: .constant(4.2)
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





struct SmallFlowerView: View {
    @Binding var isMinimized: Bool
    @Binding var numberOfPetals: Double

    /// The duration of any animation performed to the flower.
    @Binding var animationDuration: Double

    /// The diameter of each petal.
    let circleDiameter: CGFloat = 25

    /// The color of each petal. It is recommended to also use opacity to create an overlap effect.
    var color = Color(UIColor.cyan).opacity(0.6)

    /// This represents the absolute amount of rotation needed for each petal
    private var absolutePetalAngle: Double {
        return 360 / numberOfPetals
    }

    /**
     Calculates the opacity for the petal that is being added/removed.

     This is achieved by calculating the amount of travel in **degrees**
     that the petal needs to travel in order to be completely added
     to the flower and comparing it with the **nextAngle**.
     Afterwards converting this to a 0 to 1 scale.
     */
    private var opacityPercentage: Double {
        let numberOfPetals = self.numberOfPetals.rounded(.down)
        let nextAngle = 360 / (numberOfPetals + 1)
        let currentAbsoluteAngle = 360 / numberOfPetals

        let totalTravel = currentAbsoluteAngle - nextAngle
        let currentProgress = absolutePetalAngle - nextAngle
        let percentage = currentProgress / totalTravel

        return 1 - percentage
    }

    var body: some View {
        ZStack() {
            /**
             Intentionally showing an extra petal by using 0...Count, instead of 0..<Count

             This allows for the following actions:
                - Instantly animate opacity change to the extra petal
                - Snap to the next or current petal
             */
            ForEach(0...Int(7), id: \.self) {
                Circle() // Petal
                    .frame(width: circleDiameter, height: circleDiameter)
                    .foregroundColor(self.color)

                    // animate opacity only to the petal being added/removed
                    .opacity($0 == Int(self.numberOfPetals) ? self.opacityPercentage : 1)

                    // rotate the petal around it's leading anchor to create the flower
                    .rotationEffect(.degrees(self.absolutePetalAngle * Double($0)),
                                    anchor: self.isMinimized ? .center : .leading)
            }
        }
        
        // create a frame around the flower,
        // helful for adding padding around the whole flower
        .frame(width: circleDiameter * 2, height: circleDiameter * 2)


  
        
    }
    
    
    
    
}




struct SmallFlowerView_Previews: PreviewProvider {
    static var previews: some View {
        SmallFlowerView(isMinimized: .constant(true),
                   numberOfPetals: .constant(5),
                   animationDuration: .constant(4.2))
    }
}




