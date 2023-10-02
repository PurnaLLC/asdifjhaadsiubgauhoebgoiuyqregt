//
//  ChatListView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/31/23.
//

import SwiftUI
struct ChatList: View {
    @ObservedObject var viewModel = ViewModel()
    
    
    @EnvironmentObject var viewsModel: AuthViewModel
    
    
    
    //   @Bindable var datamodel: DataModel
    //    @Environment(\.modelContext) private var modelContext
    //    @Query var extractedDatas: [ExtractedData]
    @Environment (\.dismiss) var dismiss
    
    
    @State private  var isFetchingData = false
 
    
    
    @ObservedObject var vm : FirebaseMessagesViewModel
    
    
    
    @StateObject var firevm = FirebaseMessagesViewModel(ds: FirebaseMessageDataService())

    

    
    
    var body: some View {
        
        NavigationView{
            VStack {
                ScrollView {
                    
                    
                    ForEach(vm.firebaseMessages.filter({$0.role != "system"}), id: \.id) { message in
                        
                        Text("\(message.content)")
                        
                    }
                    
                }
                HStack {
                    TextField("Enter a message...", text: $viewModel.currentInput)
                    
                    Button {
                        viewModel.sendMessage(viewModel.currentInput)
                    } label: {
                        Text("Send")
                    }
                    
                }
                
                
                NavigationLink {
                    AITalk(vm: firevm)
                } label: {
                    Text("Call")
                }

            }
            .padding()
        }
    }
}

