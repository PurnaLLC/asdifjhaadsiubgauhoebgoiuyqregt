//
//  LoginView.swift
//  Wordz
//
//  Created by Maxwell Meyer on 6/6/23.
//

import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices
import Firebase



struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var fullname = ""
    @State private var messageContent = ""
    @State private var navigationSelection: String?
    


   
    
    let getUserDataTimerz = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    @EnvironmentObject var signinViewModel: SinginViewModel
    
    
    var body: some View {
        
        NavigationStack{
            Color("Logoblue")
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack{
                        //image
                        Image("Logo3")
                            .resizable()
                            .scaledToFill()
                            .frame(width:50, height: 100)
                        
                        
                        
                        
                        
                            .padding(.bottom, 10)
                        
                        //form fields
                        //email
                        VStack(spacing: 0) {
                            InputView(text: $email,
                                      title: "Email Address",
                                      placeholder: "name@example.com")
                            .autocapitalization(.none)
                            
                            .padding(.horizontal)
                            .padding(.bottom )
                            
                            //Password
                            InputView(text: $password,
                                      title: "Password",
                                      placeholder: "Enter Your Password",
                                      isSecureField: true)
                            .padding(.horizontal)
                            
                            
                            
                            NavigationLink {
                                PasswordResetView()
                                    .navigationBarBackButtonHidden(true)
                                
                            } label: {HStack(spacing: 3){
                                
                                Spacer()
                                Text("Forgot Password?")
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                                
                            }
                            .padding(.top, 25)
                            .padding(.trailing, 15)
                                
                            }
                            
                            
                        }
                        .padding(.top,2)
                        
                        //forgot passwrod
                        // NavigationLink
                        //  {}  label: {HStack{
                        //     Text("Forgot Password?")
                        //.frame(width:300,height:25)
                        //        .offset(x: 110, y:0)
                        //        .font(.system(size:15))
                        //      .fontWeight(.semibold)
                        
                        //  }
                        //    }
                        //sign in button
                        .padding(.bottom,25)
                        
                        Button {
                            Task{
                                try await viewModel.signIn(withEmail: email, password: password)
                            }
                        } label: {
                            HStack{
                                Text("SIGN IN")
                                    .fontWeight(.semibold)
                                Image(systemName:"arrow.right")
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            .background(Color(.systemBlue))
                            .disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)
                            .cornerRadius(10)
                        }
                        
                        
                        VStack{
                            
                            GoogleSiginBtn {
                                // TODO: - Call the sign-in method here
                                FirebAuth.share.signinWithGoogle(presenting: getRootViewController()) { error, success in
                                    if let error = error {
                                        // Handle error
                                        print("Sign-in failed with error: \(error.localizedDescription)")
                                    } else if success {
                                        // Handle success
                                        print("Sign-in successful")
                                        // Perform any additional actions on success
                                        Task {
                                            do {
                                                try await viewModel.createGmailUser(fullname: "", messageContent: "hello")
                                                // TODO: Navigate to Home view
                                            } catch {
                                                // TODO: Handle error from createUser
                                            }
                                        }
                                        
                                    }
                                }
                            } .padding (.top, 200)
                                .padding (.bottom, 20)

                            
                            
                            
                            
                            SignInWithAppleButton{request in
                                signinViewModel.SinginWithAppleRequest(request)
                            } onCompletion: { result in
                                signinViewModel.SinginWithAppleCompletion(result)
                            }
                            .cornerRadius(10)
                            .frame(width: 350, height: 50, alignment: .center)
                     

                            
                        }
                    .frame(width: 350, height: 175, alignment: .center)

                        
                        
                        Spacer()
                        //sign up button
                        
                        NavigationLink {
                            RegistrationView()
                                .navigationBarBackButtonHidden(true)
                            
                        } label: {HStack(spacing: 3){
                            Text("Don't have an account?")
                                .foregroundColor(.white)
                            Text("Sign up")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                        }
                        .font(.system(size:18))
                        
                            
                        }
                    }
                )
        }
        
    }
    
    
    

    
    
    
    
    
}

extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
            .background(HelperView())   // << here !!
    }
}

