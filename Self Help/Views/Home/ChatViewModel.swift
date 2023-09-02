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

extension ChatList {
    
    
   
    
  
    class ViewModel: ObservableObject {
      
        @Published var messages: [Message] = [Message(id: "first-message", role: .system, content: "", createdAt: Date())]
        
 
        
        @Published var currentInput: String = ""
        
        private let openAIService = OpenAIService()
  
        
        func sendMessage()  {
            let newMessage = Message(id: UUID().uuidString, role: .user, content: currentInput, createdAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
            
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
                            
                            let wrongfuncMessge = Message(id: UUID().uuidString, role: receivedOpenAIMessage.role, content:
                                                             
                                                            
                                                            
                                                            "Here is your requested word: Word: Serendipity. Part of Speech: Noun. Definition: The occurrence of events by chance in a beneficial or happy way. Example Sentence: Running into my old friend at the airport was such a serendipitous moment.",
                                                          
                                                          createdAt: Date())
                            
                            
                            await MainActor.run {
                                messages.append(receivedMessage)
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
    
    func storeUserMessage(currentUser: User?, message: Message) {
        if message.role == .assistant {
            guard let userId = currentUser?.id else { return }
            let db = Firestore.firestore()
            // Assuming you have a collection named "messages" in Firestore
            let subcollectionRef = db.collection("users").document(userId).collection("messages")
            let newDocumentRef = subcollectionRef.document()
            let documentData: [String: Any] = [
                "role": message.role.rawValue,
                "content": message.content,
                "timestamp": FieldValue.serverTimestamp(), // Add timestamp field
                // Add more fields as necessary
            ]
            newDocumentRef.setData(documentData) { error in
                if let error = error {
                    print("Error saving message: \(error)")
                } else {
                    print("Message saved successfully!")
                }
            }
        }
        if message.role == .user {
            guard let userId = currentUser?.id else { return }
            let db = Firestore.firestore()
            // Assuming you have a collection named "messages" in Firestore
            let subcollectionRef = db.collection("users").document(userId).collection("messages")
            let newDocumentRef = subcollectionRef.document()
            let documentData: [String: Any] = [
                "role": message.role.rawValue,
                "content": message.content,
                "timestamp": FieldValue.serverTimestamp(), // Add timestamp field
                // Add more fields as necessary
            ]
            newDocumentRef.setData(documentData) { error in
                if let error = error {
                    print("Error saving message: \(error)")
                } else {
                    print("Message saved successfully!")
                }
            }
        }
    }
    
    func getUserData(currentUser: User?, completion: @escaping ([String], [Date], [String]) -> Void) {
        guard let userId = currentUser?.id else {
            completion([], [], [])
            return
        }
        let db = Firestore.firestore()
        let subcollectionRef = db.collection("users").document(userId).collection("messages")
        subcollectionRef.order(by: "timestamp", descending: false).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion([], [], [])
            } else {
                var fetchedMessages: [String] = []
                var fetchedTimestamps: [Date] = []
                var fetchedRole: [String] = []
                for document in querySnapshot?.documents ?? [] {
                    let data = document.data()
                    if let messageContent = data["content"] as? String {
                        fetchedMessages.append(messageContent)
                    }
                    if let role = data["role"] as? String {
                        fetchedRole.append(role)
                    }
                    if let timestamp = data["timestamp"] as? Timestamp {
                        let date = timestamp.dateValue()
                        fetchedTimestamps.append(date)
                    }
                }
                completion(fetchedMessages, fetchedTimestamps, fetchedRole)
            }
        }
    }
    
}
struct newCharacter: Identifiable{
    var id: String = UUID().uuidString
    var value: String
    var index: Int = 0
    var rect: CGRect = .zero
    var pusOffset: CGFloat = 0
    var isCurrent: Bool = false
 //   var color: Color = .clear
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

