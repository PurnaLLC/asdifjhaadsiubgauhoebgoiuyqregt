//
//  CheckinEditView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/22/23.
//

import SwiftUI

struct CheckinEditView: View {
    
    
    @State var checkin: CheckIn
    var save: (CheckIn)->()
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        VStack{
            HStack {
                
                
                VStack{
                    
                    
                    
                    Text("Integer Value: \(checkin.day1to10)")
                    
                    Stepper(value: $checkin.day1to10, in: 0...10, step: 1) {
                        Text("Increment")
                        
                        
                        
                        Text("Date: \(checkin.formattedDate())")
                        
                        
                        VStack(alignment: .center){
                            
                            TextField("Description of Day", text: $checkin.name, axis: .vertical)
                                .lineLimit(2)
                                .textFieldStyle(.roundedBorder)
                                .padding()
                            
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
                }
                
                
            }.padding(.leading, 7)
            
                
                
                
                
            
            
            
            
            Button {
                save(checkin)
                dismiss()
               
            } label: {
                Text("Save")
            }
            
      
            
            
        }
        .padding()
        
        
        
    }
}

