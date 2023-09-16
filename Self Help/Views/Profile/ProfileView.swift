//
//  ProfileView.swift
//  Wordz
//
//  Created by Maxwell Meyer on 6/6/23.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import AVKit




struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
  
    
    @State var multiColor = false
    

    @State private var indexOffset = 0
    
    @State private var showMenu: Bool = false
    
    
    
    let getUserDataTimerz = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    


    @State  private var isShowingPracticeWord = false
    
    
    @State private var selectedWord: String?

    
    
    var body: some View {
        
        
        
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
            
            
            
            if let user = viewModel.currentUser{
                
                
                VStack{
                    
                    
                    
                    
                    
                    HStack {
                        HStack{
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 50))
                            
                            
                            
                            
                            VStack (alignment: .leading, spacing:4){
                                Text(user.email)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top,4)
                              
                                
                                VStack(alignment: .center){
                                    Text("TIER 1")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .padding(.top,4)
                                }
                                
                                
                            }
                            
                            
                            
                            
                            
                        }
                        .padding()
                        .padding(.leading)
                        
                        Menu {
                            
                            
                            
                            Button {
                                
                                viewModel.signOut()
                                
                            } label: {
                                SettingsRowView(imageName:"arrow.left.circle.fill",
                                                title: "Sign Out",
                                                tintColor:.red)
                            }
                         
                            
                            Menu {
                                Button(role: .destructive) {
                          
                                        viewModel.deleteUser { result in
                                            switch result {
                                            case .success:
                                                viewModel.signOut()
                                                
                                                
                                                Task{
                                                    do{
                                                        
                                                        viewModel.userSession = nil
                                                        viewModel.currentUser = nil
                                                    }
                                                }
                                                
                                                
                                                
                                                
                                                if viewModel.userSession != nil {
                                                    // Navigate to HomeView
                                                    // Assuming `HomeView` is a SwiftUI view
                                                    
                                                } else {
                                                    // Navigate to LoginView
                                                    // Assuming `LoginView` is a SwiftUI view
                                                    
                                                }
                                            case .failure(let error):
                                                // Error occurred while deleting user, display an error message or handle the error
                                                print("Error deleting user: \(error)")
                                            }
                                        }
                                    viewModel.signOut()

                                    
                          
                                } label: {
                                    Label("Delete Account", systemImage: "xmark.circle.fill")
                                    
                                }
                                
                                
                                
                                
                                
                            } label: {
                                Label("Delete Account", systemImage: "xmark.circle.fill")
                            }
                            
                        } label: {
                            SettingsRowView(imageName:"gearshape.fill",
                                            title: "",
                                            tintColor:.black)
                            .frame(width:72, height: 72)
                            
                        }
                        
                       
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
                
            }
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    
   


    
    
    
    
    
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AuthViewModel())
            .background(HelperView())   // << here !!x
    }
}


