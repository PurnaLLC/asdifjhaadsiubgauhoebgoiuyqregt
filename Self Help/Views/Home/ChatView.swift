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
        
        NavigationStack{
            
            
            ZStack{
                
                LinearGradient(
                    colors: [Color("logoblue"),Color("logoblue")],
                    startPoint: .top,
                    endPoint: .bottom)
                .ignoresSafeArea()
                
                // Gloss Background....
                GeometryReader{proxy in
                    
                    let size = proxy.size
                    
                    // Slighlty Darkening ...
                    Color.black
                        .opacity(0.7)
                        .blur(radius: 200)
                        .ignoresSafeArea()
                    
                    Circle()
                        .fill(Color("Logoblue"))
                        .padding(50)
                        .blur(radius: 120)
                    // Moving Top...
                        .offset(x: -size.width / 1.8, y: -size.height / 5)
                    
                    Circle()
                        .fill(Color("Logoblue"))
                        .padding(50)
                        .blur(radius: 150)
                    // Moving Top...
                        .offset(x: size.width / 1.8, y: -size.height / 2)
                    
                    
                    Circle()
                        .fill(Color("Logoblue"))
                        .padding(50)
                        .blur(radius: 90)
                    // Moving Top...
                        .offset(x: size.width / 1.8, y: size.height / 2)
                    
                    // Adding Purple on both botom ends...
                    
                    Circle()
                        .fill(Color("Logoblue"))
                        .padding(100)
                        .blur(radius: 110)
                    // Moving Top...
                        .offset(x: size.width / 1.8, y: size.height / 2)
                    
                    Circle()
                        .fill(Color("Logoblue"))
                        .padding(100)
                        .blur(radius: 110)
                    // Moving Top...
                        .offset(x: -size.width / 1.8, y: size.height / 2)
                    
                    
                }
                
                VStack{
                   
  
                    if let dataOfTheDay = view2Model.dataOfTheDay {
                        Text("Date: \(dataOfTheDay.date)")
                        Text("Affirmation: \(dataOfTheDay.affirmation)")
                        Text("Challenge: \(dataOfTheDay.challenge ?? "No challenge today")")
                        Text("Greeting: \(dataOfTheDay.greeting ?? "Hello!")")
                    } else {
                        Text("Loading data...")
                    }
                    
                }
            }
            
            
            //       .navigationBarHidden(true)
            
            
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
    
    
    
    
    
    
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of ChatView.DataModel
        
        ChatView().environmentObject(AuthViewModel())
            .background(HelperView())   // << here !!
        
        // Fallback on earlier versions
        
        
        
    }
}




