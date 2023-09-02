//
//  ChatListView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/31/23.
//

import SwiftUI
struct ChatList: View {
    @ObservedObject var viewModel = ViewModel()
    
    @ObservedObject private var view2Model = DataViewModel()
    
    @EnvironmentObject var viewsModel: AuthViewModel
    
    
    
    //   @Bindable var datamodel: DataModel
    //    @Environment(\.modelContext) private var modelContext
    //    @Query var extractedDatas: [ExtractedData]
    @Environment (\.dismiss) var dismiss
    
    
    
    @State private var extractedMessages: [String] = []
    @State private var extractedTimestamps: [Date] = []
    @State private var extractedRole: [String] = []
    @State private var fetchedMessages: [String] = []
    @State private var fetchedTimestamps: [Date] = []
    @State private var fetchedRole: [String] = []
    @State private  var isFetchingData = false
    let getUserDataTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ScrollView{
                
                LazyVStack{
                    VStack(alignment: .center){
                        
                        
                        ForEach(viewModel.messages.filter({$0.role != .system}), id: \.id) { message in
                            messageView(message: message)
                            
                            
                            
                        }
                        
                    
                        ForEach(fetchedMessages.indices, id: \.self) { index in
                            let message = fetchedMessages[index]
                            let role = fetchedRole[index]
                            Text("\(message)")
                                .foregroundColor(role == "user" ? .red : .blue)
                        }
                        
                        
                                    }
                                }
                            }
            
            
            
                
                            .onReceive(getUserDataTimer) { time in
                                if isFetchingData {
                                    getUserData(currentUser: viewsModel.currentUser) { fetchedMessages, fetchedTimestamps, fetchedRole in
                                        self.fetchedMessages = fetchedMessages
                                        self.fetchedTimestamps = fetchedTimestamps
                                        self.fetchedRole = fetchedRole
                                        
                                        
                                        
                                        //          .padding(.trailing,20)
                                        
                                    }
                }
                
            }
            HStack {
                TextField("Enter a message...", text: $viewModel.currentInput)
                
                Button {
                    viewModel.sendMessage()
                    
                           
                } label: {
                    Text("Send")
                }
                
            }
            
        }
        .onAppear{
            isFetchingData = true
                  
                  // Schedule a timer to stop fetching after 5 seconds
                  DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                      isFetchingData = false
                  }
            
        }
        .padding()
    }
    
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == .user {
                Spacer()
            }
            
            ZStack{
                
            }
            
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.0, repeats: false) { _ in
                        withAnimation {
                            
                        
                                
                            storeUserMessage(
                                    currentUser: viewsModel.currentUser,
                                    message: message
                                    
                                )
                            
                            
                            isFetchingData = true
                                  
                                  // Schedule a timer to stop fetching after 5 seconds
                                  DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                      isFetchingData = false
                                  }
                            
                                // Call getUserData to fetch the subcollection data
                            
                        }
                    }
                }
            
            
            if message.role == .assistant {
                Spacer()
            }
        }
    }
    
}
struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}

