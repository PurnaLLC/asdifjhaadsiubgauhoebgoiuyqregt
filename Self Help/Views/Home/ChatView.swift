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


let speechSynthesizer = AVSpeechSynthesizer()
let height: CGFloat = UIScreen.main.bounds.height
let width: CGFloat = UIScreen.main.bounds.width


struct ChatView: View {
    
    @ObservedObject private var view2Model = DataViewModel()
    @EnvironmentObject var viewsModel: AuthViewModel
    @Environment (\.dismiss) var dismiss
    @State private var dataOfTheDay: DataOfTheDay?
    @State private var showVideo = false

    
    @StateObject var vm = FirebaseMessagesViewModel(ds: FirebaseMessageDataService())

    
    
    
    var body: some View {
        NavigationView {
            VStack{
         
       

                
            
                if let dataOfTheDay = view2Model.dataOfTheDay {
            
                
                    
                    let date = Date()
                    
                    
      
                        
                        Text(" \(dataOfTheDay.greeting1 ?? "")  \(currentDateFormat(from: date)) \(dataOfTheDay.greeting2 ?? "") ")
                        
                            .font(.system(size: 39, weight: .ultraLight, design: .default))
                            .frame(width: width * 0.8, height: height * 0.15,
                                   alignment: .top)
                            .padding(.top, UIScreen.main.bounds.height * 0.025)
                  
                    
                    
                    
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Dailys")
                                .font(.title)
                                .frame(alignment: .top)
                                .padding(22)
                        }
                    }
                    
                    VStack{
                        HStack{
                            Text("Affirmation")
                            Spacer()
                        }
                        .padding(.leading, 60)
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .topLeading) {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: width, height: geometry.size.height)
                                
                            //    Text(dataOfTheDay.affirmation)
                             //       .padding()
                            }
                            
                            
                            
                            HStack{
                                Text("Challenge")
                                Spacer()
                            }
                            .padding(.leading, 60)
                         /*
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
                            */
                            
                            
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
                        NavigationLink(destination: ChatList( vm: vm)) {
                            // destination view to navigation to
                            
                            
                            
                          /*
                            
                            HStack{
                                Spacer()
                                Text("  Greeting: \(dataOfTheDay.greeting ?? "Hello!")")
                                    .frame(minWidth: 335, idealWidth: 335, maxWidth: 335, minHeight: 1, idealHeight: 10, maxHeight: 60, alignment: .leading)
                                    .foregroundColor(.black)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.red, lineWidth: 3)
                                            .padding(0)
                                    )
                                    .padding(.trailing, 20)
                            }
                            
                            */
                            
                        }
                        Spacer()
                    }
                    
                }
                else {
                    Text("Someone did an oopsie in this code...")
        
                    
        
                }
                
            }
        }
    }
        struct CustomPaths: View {
            let height = UIScreen.main.bounds.height
            let width = UIScreen.main.bounds.width
            
            var body: some View {
                VStack {
                    Path { path in
                        path.move(to: CGPoint(x: width * 0.05, y: height * 0.9))
                        path.addLine(to: CGPoint(x: width * 0.05, y: height * 0.1))
                    }
                    .stroke(Color.red, lineWidth: 3)
                    
                    Path { path in
                        path.move(to: CGPoint(x: width * 0.05, y: height * 0.5))
                        path.addLine(to: CGPoint(x: width * 0.15, y: height * 0.5))
                    }
                    .stroke(Color.red, lineWidth: 3)
                    
                    Path { path in
                        path.move(to: CGPoint(x: width * 0.05, y: height * 0.7))
                        path.addLine(to: CGPoint(x: width * 0.15, y: height * 0.7))
                    }
                    .stroke(Color.red, lineWidth: 3)
                }
            }
        }
    

    
    
    }

  
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            
            ChatView().environmentObject(AuthViewModel())
                .background(HelperView())   // << here !!
            
            // Fallback on earlier versions
            
            
            
        }
        
        
    }
    

