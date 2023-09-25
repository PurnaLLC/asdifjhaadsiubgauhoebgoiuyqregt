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
                            BreathAnimationCategoryView(title: "relaxora", description: "penis ara ara ara ara ara ara")
                            
                        }
                        NavigationLink {
                            SettingsForBreatheAnimationView(breathInHold: 0, breathOutHold: 0, breathOutDuration: 4, breathInDuration: 6,maxBreathCount: 30, DoubleMaxBreathCount: 30, previousTotalBreatheDuration: 10, previewsTotalBreatheSession: 30, totalBreatheDuration: 10 ,  totalBreatheSession: 300,  previousMaxBreathCount: 30)
                            
                            
                        } label: {
                            BreathAnimationCategoryView(title: "relaxora", description: "penis ara ara ara ara ara ara")

                        }
                        
                        
                        
                        
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

