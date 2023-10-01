//
//  BreathAnimationPickerView.swift
//  BreathingAnimation
//
//  Created by Maxwell Meyer on 9/25/23.
//  Copyright © 2023 CodingBytes. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
struct BreathAnimationPickerView: View {
    

    var body: some View {
        
        
        
       
        
        
        
        NavigationView {
            
            
            
            VStack{
                VStack{
                    Text("Breathe Work")
                        .font(.system(size: 40))
                    
                    
                 
                }
                
                VStack(alignment: .leading){
                    Text("ARA ARA ARA ARA ARA")
                    
                }
                
                .padding(.bottom, 75)
                
                
                ScrollView{
                    
                    
                    
                    VStack{
                        
                        
      
                        
                        
                        
                        NavigationLink {
                            SettingsForBreatheAnimationView(breathInHold: 0, breathOutHold: 0, breathOutDuration: 4, breathInDuration: 6,maxBreathCount: 30, DoubleMaxBreathCount: 30, previousTotalBreatheDuration: 10, previewsTotalBreatheSession: 30, totalBreatheDuration: 10 ,  totalBreatheSession: 300,  previousMaxBreathCount: 30)
                            
                            
                            
                        } label: {
                            BreathAnimationCategoryView(title: "relaxora", description: "penis ara ara ara ara ara ara")
                            
                        }
                        NavigationLink {
                            SettingsForBreatheAnimationView(breathInHold: 0, breathOutHold: 0, breathOutDuration: 4, breathInDuration: 6,maxBreathCount: 30, DoubleMaxBreathCount: 30, previousTotalBreatheDuration: 10, previewsTotalBreatheSession: 30, totalBreatheDuration: 10 ,  totalBreatheSession: 300,  previousMaxBreathCount: 30)
                            
                            
                        } label: {
                            BreathAnimationCategoryView(title: "relaxora", description: "penis ara ara ara ara ara ara")
                            
                        }
                        NavigationLink {
                            SettingsForBreatheAnimationView(breathInHold: 0, breathOutHold: 0, breathOutDuration: 4, breathInDuration: 6,maxBreathCount: 30, DoubleMaxBreathCount: 30, previousTotalBreatheDuration: 10, previewsTotalBreatheSession: 30, totalBreatheDuration: 10 ,  totalBreatheSession: 300,  previousMaxBreathCount: 30)

                            
                            
                            
                        } label: {
                            BreathAnimationCategoryView(title: "relaxora", description: "penis ara ara ara ara ara ara")
                            
                        }
                        
                        NavigationLink {
                            SettingsForBreatheAnimationView(breathInHold: 0, breathOutHold: 0, breathOutDuration: 4, breathInDuration: 6,maxBreathCount: 30, DoubleMaxBreathCount: 30, previousTotalBreatheDuration: 10, previewsTotalBreatheSession: 30, totalBreatheDuration: 10 ,  totalBreatheSession: 300,  previousMaxBreathCount: 30)
                            
                        } label: {
                            BreathAnimationCategoryView(title: "relaxora", description: " ara ara ara ara ara ara")
                            
                        }
                        NavigationLink {
                            WimHofBreatheSettings(breathInHold: 0, breathOutHold: 0, breathOutDuration: Int(round(1.5)), breathInDuration: Int(round(1.5)), maxBreathCount: 90, DoubleMaxBreathCount: 90, previousTotalBreatheDuration: 3, previewsTotalBreatheSession: 585, totalBreatheDuration: 3 ,  totalBreatheSession: 585,  previousMaxBreathCount: 90, breath30HoldOut: 90, breath30HoldIn: 15 , breath30HoldIndex: 3, previousDouble30Hold: 90, Double30hold: 90
                            )
                            
                            
                           
                            
                            
                        } label: {
                            BreathAnimationCategoryView(title: "Wim hof", description: " ara ara ara ara ara ara")

                        }
                        
                        //540
                        
                        
                    }
                    
                }
            }
        }
        
        
        
    }
}

@available(iOS 14.0, *)
struct BreathAnimationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        BreathAnimationPickerView()
    }
}

