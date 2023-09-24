//
//  CheckInEditView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/4/23.
//

import SwiftUI

struct CreateCheckinView: View {
    @State var checkin: CheckIn
    var save: (CheckIn)->()
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var uservm: UserDataViewModel

    @EnvironmentObject var viewModel: AuthViewModel
    
    
    @State  var currentStreak: Int

    var body: some View {

            
       
        
            VStack{
                HStack {
                    
                    
                    VStack{
                        
                        
                        
                        Text("Integer Value: \(checkin.day1to10)")
                        
                        Stepper(value: $checkin.day1to10, in: 0...10, step: 1) {
                            Text("Increment")
                            
                            Text("Date: \(checkin.formattedDate())")
                            
                            
                            VStack(alignment: .center){
                                
                                TextField("Description of day", text: $checkin.name, axis: .vertical)
                                    .lineLimit(6)
                                    .textFieldStyle(.roundedBorder)
                                    .padding()
                                    .frame(width: 300)
                            }
                        }
                        
                        VStack {
                            DatePicker("Finished By", selection: $checkin.date, in: Date()..., displayedComponents: .date)
                            
                              }
                        
                        

                        
                        
                    }
                    
                    
                }.padding(.leading, 7)
                
                Button {
                    save(checkin)
                    dismiss()
                    
                    
                    
                    if let user = viewModel.currentUser{
                        
                        
                        uservm.increaseStreak(user.id, currentStreak)
                        
                        
                        
                    }
                    
                    
                } label: {
                    Text("Save")
                }
            }
            .padding()
        }
        
      
    
    


}

