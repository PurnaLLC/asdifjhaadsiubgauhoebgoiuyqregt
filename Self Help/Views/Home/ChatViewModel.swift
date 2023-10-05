//
//  ChatViewModel.swift
//  WordzAI
//
//  Created by Maxwell Meyer on 6/16/23.
//
//

import Foundation

import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import Combine



    
    
    class ViewModel: ObservableObject {
        
        @Published var messages: [Message] = [Message(id: "first-message", role: .system, content: "You are an AI that helps people with their mental health. You will act as a friend or therapist. You will only talk about mental health. I am will talk with you about my day.", createdAt: Date())]
        
        
        
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAIService()
        
        
 
        

        
        func sendMessage(_ content: String)  {
            let newMessage = Message(id: UUID().uuidString, role: .user, content: content, createdAt: Date())
            messages.append(newMessage)

            let firebaseUSerMessage = FirebaseMessage(role: newMessage.role.rawValue, content: newMessage.content)

            add(firebaseUSerMessage)
            //          let newMessage = Message(id: UUID().uuidString, role: .user, content: " I want 1 word. In this category: \(selectedPickerIndex3). I want this difficulty: \(selectedPickerIndex2). Do NOT give me any of these old words: \(oldWords)", createdAt: Date())
            
            
            
            //     messages.append(newMessage)
            
            print(" MAX LOOK HERE \(newMessage)")
            
            
            Task {
                let response = await openAIService.sendMessage(messages: messages)
                guard let receivedOpenAIMessage = response?.choices.first?.message else {
                    print("Had no received message")
                    return
                }
                let receivedMessage = Message(id: UUID().uuidString, role: receivedOpenAIMessage.role, content: receivedOpenAIMessage.content, createdAt: Date())
                
                
                let firebaseAIMessage = FirebaseMessage(role: receivedMessage.role.rawValue, content: receivedMessage.content)
                
                

        
                
                await MainActor.run {
                    messages.append(receivedMessage)
                    print("\(receivedMessage)")
  
                    add(firebaseAIMessage)
               
                }
             
                
         
                
            }
            
            
            
            
            
            
        }
        
        
        
        
        
        func parseStreamData(_ data: String) ->[ChatStreamCompletionResponse] {
            let responseStrings = data.split(separator: "data:").map({$0.trimmingCharacters(in: .whitespacesAndNewlines)}).filter({!$0.isEmpty})
            let jsonDecoder = JSONDecoder()
            
            return responseStrings.compactMap { jsonString in
                guard let jsonData = jsonString.data(using: .utf8), let streamResponse = try? jsonDecoder.decode(ChatStreamCompletionResponse.self, from: jsonData) else {
                    return nil
                }
                return streamResponse
            }
        }
        
        
        
        
        
 
        
        
        
        
    }
    

    
    
    func add(_ firebaseMessage: FirebaseMessage) {
        
        
         let db = Firestore.firestore()
         let collectionName = "firebaseMessages"
        
        
        guard let userId = Auth.auth().currentUser?.uid else {
            print("User is not authenticated.")
            return
        }
        
        var checkinWithUserId = firebaseMessage
        checkinWithUserId.userId = userId

        do {
            let documentReference = try db.collection(collectionName).addDocument(from: checkinWithUserId)
            checkinWithUserId.documentId = documentReference.documentID
        } catch {
            print("Error adding checkin to Firestore: \(error)")
        }
    }


struct newCharacter: Identifiable{
    var id: String = UUID().uuidString
    var value: String
    var index: Int = 0
    var rect: CGRect = .zero
    var pusOffset: CGFloat = 0
    var isCurrent: Bool = false
    
}

struct Message: Decodable, Hashable {
    let id: String
    let role: SenderRole
    let content: String
    let createdAt: Date

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}



struct ChatStreamCompletionResponse: Decodable {
    let id: String
    let choices: [ChatStreamChoice]
}
struct ChatStreamChoice: Decodable {
    let delta: ChatStreamContent
}
struct ChatStreamContent: Decodable {
    let content: String
}






//"You are an AI designed to help users learn words. The user will send you three pieces of information: the number of words they want to learn, the desired difficulty level, and the category of words they're interested in. Your task is to provide the requested words along with their corresponding part of speech, definition, and example sentence. Please ensure that the part of speech matches the word, the definition aligns with the word's meaning, and the example sentence includes the word to facilitate effective learning. If you encounter any issues, please try to provide the word again so that I can assist you better. Let's embark on this learning journey together!"



//You are an AI that helps users learn words. The user will send you three things: 1. A number representing the amount of words they want to learn. 2. The difficulty level of the words they want. 3. The category for the words they want. In response, you will provide the following information for each based off the inputs the user puts in, in this format: word: Word, Part of Speech: part of speech, Definition: definition, Example Sentence: example sentence. Please ensure that the part of speech matches the word, the definition matches the word, and the example sentence includes the word. Following this format and providing the word for each element in your response is crucial to effectively teach the user.

