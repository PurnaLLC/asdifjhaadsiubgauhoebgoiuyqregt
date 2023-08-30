//
//  ContentView.swift
//  WordzAI
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



   
    
    
struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    @ObservedObject private var view2Model = DataViewModel()
    
    @EnvironmentObject var viewsModel: AuthViewModel
    
    
    //   @Bindable var datamodel: DataModel
    //    @Environment(\.modelContext) private var modelContext
    //    @Query var extractedDatas: [ExtractedData]
    @Environment (\.dismiss) var dismiss
    
    
    @State private var dataOfTheDay: DataOfTheDay?
    
    
    
    
    var body: some View {
        ChatView()
    }
    struct CustomLine: View {
        var body: some View {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 500, y: -500))
            }
            .stroke(Color.red, lineWidth: 3)
            .background(Color.black.opacity(0.3))
            .frame(width: 500, height: 500)
        }
    }

    
    struct ChatView: View {
        var body: some View {
            VStack{
                CustomLine()
                
                if let dataOfTheDay = view2Model.dataOfTheDay {
                    ZStack(alignment: .top) {
                        VStack{
                            Text("Make \(dataOfTheDay.date) a great day???")
                                .frame(minWidth: 200, idealWidth: 200, maxWidth: 200, minHeight: 5, idealHeight: 50, maxHeight: 100, alignment: .topLeading)
                                .padding(5)
                            
                            VStack(alignment: .leading){
                                HStack{
                                    
                                    Text("Dailys")
                                        .font(.title)
                                        .frame(alignment: .top)
                                        .padding(22)
                                    Spacer()
                                }
                            }
                            
                            
                        }
                        Spacer()
                        
                    }
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
                    
                    
                    VStack{
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
                    }
                    Spacer()
                    
                    
                    VStack{
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
                                .frame(minWidth: 335, idealWidth: 335, maxWidth: 335, minHeight: 90, idealHeight: 100, maxHeight: 150, alignment: .leading)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red, lineWidth: 3)
                                        .padding(0)
                                )
                                .padding(.trailing, 20)
                        }
                    }
                    
                    Spacer()
                } else {
                    Text("Loading data...")
                }
                
            }
        }
        
        
        //       .navigationBarHidden(true)
        
        
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
    
