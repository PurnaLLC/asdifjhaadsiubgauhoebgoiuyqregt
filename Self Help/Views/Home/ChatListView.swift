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
                        
                        
                        HStack{
                            
                            Menu {
                                Button(role: .destructive) {
                                    
                                    vm.delete(firebasemessage: message)
                                    
                                } label: {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.red)
                                        .cornerRadius(10)
                                        .multilineTextAlignment(.center)
                                    Text("Delete Chechin")
                                    
                                    
                                }
                                
                                
                                
                                
                                
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                    .multilineTextAlignment(.center)
                                
                                
                            }
                        }
                        .frame(maxWidth: 120, alignment: .trailing)
                        .padding(.trailing, 10)
                        
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

