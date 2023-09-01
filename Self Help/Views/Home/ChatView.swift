//
//  ContentView.swift
//  AIgirlfriend.proj
//
//  Created by Maxwell Meyer on 6/15/23.
//

//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import AVFoundation
import Combine
import GoogleUtilities_UserDefaults
import Combine


let speechSynthesizer = AVSpeechSynthesizer()



   
    
    
struct ChatView: View {
    @ObservedObject var viewModel = ViewModel()
    
    @ObservedObject private var view2Model = DataViewModel()
    
    @EnvironmentObject var viewsModel: AuthViewModel
    
    
    //   @Bindable var datamodel: DataModel
    //    @Environment(\.modelContext) private var modelContext
    //    @Query var extractedDatas: [ExtractedData]
    @Environment (\.dismiss) var dismiss
    
    
    @State private var dataOfTheDay: DataOfTheDay?
    
    
    
    
    var body: some View {
        
            VStack{
                
                
                if let dataOfTheDay = view2Model.dataOfTheDay {
                   
                     
                            
                        
                            Spacer()
                            Text("Make \(dataOfTheDay.date) a great day")
                                .font(.system(size: 30, weight: .ultraLight, design: .default))
                                .frame(minWidth: 300, idealWidth: 300, maxWidth: 300, minHeight: 0, idealHeight: 50, maxHeight: 100, alignment: .topLeading)
                                .padding(0)
                              
                            
                            
                            VStack(alignment: .leading){
                                CustomLine()
                                HStack{
                                    
                                    Text("Dailys")
                                        .font(.title)
                                        .frame(alignment: .top)
                                        .padding(22)
                                        .position(x: 59.34, y: -10)
                                   
                                }
                              
                            }
                            
                        
                        
                       
                        
                    VStack{
                        HStack{
                            Text("Affirmation")
                            Spacer()
                        }
                        .padding(.leading, 60)
                        
                        HStack{
                            Spacer()
                            Text("  \(dataOfTheDay.affirmation)")
                                .frame(minWidth: 335, idealWidth: 335, maxWidth: 335, minHeight: 1, idealHeight: 10, maxHeight: 100, alignment: .leading)
                            
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 3)
                                        .padding(0)
                                )
                                .padding(.trailing, 20)
                        }
                        
                        
                        
                        HStack{
                            Text("Challenge")
                            Spacer()
                        }
                        .padding(.leading, 60)
                        
                        HStack{
                            Spacer()
                            Text("  \(dataOfTheDay.challenge ?? "No challenge today")")
                                .frame(minWidth: 335, idealWidth: 335, maxWidth: 335, minHeight: 1, idealHeight: 10, maxHeight: 100, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 3)
                                        .padding(0)
                                )
                                .padding(.trailing, 20)
                        }
                        Spacer()
                    }
                    
                    
                
                        HStack{
                            Text("AI Therapy")
                                .font(.title)
                                .frame(alignment: .leading)
                                .padding(2)
                            Spacer()
                        }
                        .padding(.leading, 22)
                        HStack{
                            Spacer()
                            Text("  Greeting: \(dataOfTheDay.greeting ?? "Hello!")")
                                .frame(minWidth: 335, idealWidth: 335, maxWidth: 335, minHeight: 1, idealHeight: 10, maxHeight: 60, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 3)
                                        .padding(0)
                                )
                                .padding(.trailing, 20)
                        }
                    
                    
                    Spacer()
                } else {
                    Text("Loading data...")
                }
                
            }
        
    }
    struct CustomLine: View {
        var body: some View {
            VStack{
                Path { path in
                    path.move(to: CGPoint(x: 13, y: 433.5))
                    path.addLine(to: CGPoint(x: 13, y: 112.7))
                }
                .stroke(Color.red, lineWidth: 3)
                
                
                Path { path in
                    path.move(to: CGPoint(x: 13, y: 250))
                    path.addLine(to: CGPoint(x: 38, y: 250))
                }
                .stroke(Color.red, lineWidth: 3)
                
                
         
                Path { path in
                    path.move(to: CGPoint(x: 13, y: 350))
                    path.addLine(to: CGPoint(x: 38, y: 350))
                }
                .stroke(Color.red, lineWidth: 3)
                
            }
        }
    }
    
    
}
    
    
    
    
    
    
    func messageView(message: Message) -> some View {
        HStack {
            
            if message.role == .assistant{
                Text(message.content)
                
                    .padding()
                    .background(message.role == .user ? Color.blue : Color.gray.opacity(0.2))
                if message.role == .assistant { Spacer()}
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            // Create an instance of ChatView.DataModel
            
            ChatView().environmentObject(AuthViewModel())
                .background(HelperView())   // << here !!
            
            // Fallback on earlier versions
            
            
            
        }
        
        
    }
    

