//
//  AITalk.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/27/23.
//

import SwiftUI
import AVFoundation





struct AITalk: View {
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    
    @State private var isRecording = false
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
    

    @State private var previousTranscript: String =  ""
    
   // @State private var p
    @State private var ChatGPTMessage: String = ""
    @State private var isShowingFinishedButton: Bool = false
    
    @State private var ChatGPTMessageIndex: Int = 0
    
    
    
    @ObservedObject var viewModel = ViewModel()
    
    @ObservedObject var vm : FirebaseMessagesViewModel

    
    @State private var AIisTalking = false
    @State private var index: Int = 0
    var body: some View {
        NavigationView {
            VStack {
            //    Text("\(ChatGPTMessage)")
                
                    
                
                ScrollView {
                    
              
                    
                    ForEach(vm.firebaseMessages.filter({$0.role != "system"}), id: \.id) { message in
                        
                        
                   
                        
                        if message.role == "assistant"{
                            Text("\(message.content)")
                                .foregroundColor(Color .blue)
                        
                                
                        }else{
                            
                            Text("\(message.content)")
                                .foregroundColor(Color .red)
                            
                            
                        }
                    }
                    
                    
                    .onReceive(vm.$firebaseMessages) { messages in
                        for message in messages {
                            if message.role == "assistant" {
                                let utterance = AVSpeechUtterance(string: message.content)
                                utterance.pitchMultiplier = 1.0
                                utterance.rate = 0.5
                                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                                speechSynthesizer.speak(utterance)
                            }
                        }
                    }

                    
                    
            
                }
                
                
    
    
            

                if isShowingFinishedButton {
                    Text("THE CODE WORKS")
                }
                
                
                Text("SuS")
                    .onAppear {
                        startTalk()
                        
                        ChatGPTMessage = speechRecognizer.transcript
                       
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            
                            loopMessage()
         
                        }
                        
                        
                    }
                
                
                NavigationLink {
                    Home()
                } label: {
                    Text("Back")
                }
            }
            
    
        }
          
        }
    
    

    
    
    
    
    
    
        
        private func startTalk() {
      
            speechRecognizer.resetTranscript()
            speechRecognizer.startTranscribing()
            
            
            isRecording = true
           
        }
        
        private func endTalk() {
            speechRecognizer.stopTranscribing()
            isRecording = false
            
        }
    
    private func loopMessage(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            
            ChatGPTMessage = speechRecognizer.transcript
            
            
            if ChatGPTMessage.isEmpty{
                
            }else{
                if ChatGPTMessage == previousTranscript{
                    ChatGPTMessageIndex += 1
                    
                    
                }else{
                    
                    previousTranscript = ChatGPTMessage
                    
                    
                }
    
            }
            
     
            
            if ChatGPTMessageIndex == 4{
                
                viewModel.sendMessage(ChatGPTMessage)
                
                
                
                startTalk()
                ChatGPTMessageIndex = 0
            }
         
            
            
            
            print ("\(ChatGPTMessage)")
            print ("index \(ChatGPTMessageIndex)")
            
            loopMessage()
            
            
            
            
            
            print(ChatGPTMessage)
        }

    }
    
    
    
}



/*
if previousTranscript.isEmpty{
    
    
        endTalk()
        
        print("done")
    
    
    print(previousTranscript)
    
    print(speechRecognizer.transcript)
    
    
}else{
    startTalk()
    loopMessage()
    
        
    

    print(previousTranscript)
    
    
}
 
 
 
 
 
 
 
 
 
 
 
 let utterance = AVSpeechUtterance(string: message.content)
 utterance.pitchMultiplier = 1.0
 utterance.rate = 0.5
 utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
 speechSynthesizer.speak(utterance)
 
 

*/
