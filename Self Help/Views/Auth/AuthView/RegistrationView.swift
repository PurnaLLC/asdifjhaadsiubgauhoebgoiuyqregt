//
//  RegistrationView.swift
//  Wordz
//
//  Created by Maxwell Meyer on 6/6/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State  var selectedProblems: [String]
    @State  var userName: String
    @State  var userGender: String
    
    
    
    var body: some View {
        
        
        
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
            VStack(spacing: 24) {
                InputView(text: $email,
                          title: "Email Address",
                          placeholder: "name@example.com")
                .autocapitalization(.none)
                
                
                InputView(text: $fullname,
                          title: "Full Name ",
                          placeholder: "Enter your name")
             
                
                //Password
                InputView(text: $password,
                          title: "Password",
                          placeholder: "Enter Your Password",
                          isSecureField: true)
                ZStack(alignment: .trailing){
                    //Confirm Password
                    InputView(text: $confirmPassword,
                              title: "Confirm Password",
                              placeholder: "Confirm Your Password",
                              isSecureField: true)
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        }else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))

                            
                        }
                    }
                }
                
            }
            .padding(.horizontal)
            .padding (.top,12)
            
            Button {
                Task{
                    try await viewModel.createUser(withEmail: email, password: password, fullname: fullname, userSelectedProblems: selectedProblems ,userGender: userGender ,userName: userName)
                }
            } label: {
                HStack{
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName:"arrow.right")
                }
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 25)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {HStack(spacing: 3){
                Text("Already have an account?")
                    .foregroundColor(.white)
                Text("Sign In")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .font(.system(size:18))
                
                
                }
            }
        )
    }
}

extension RegistrationView: AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        && confirmPassword == password
        && !fullname.isEmpty
        
    }
}



