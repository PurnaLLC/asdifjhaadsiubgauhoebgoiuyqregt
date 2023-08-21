//
//  ForgotPassword.swift
//  WordzAI
//
//  Created by Maxwell Meyer on 7/31/23.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices
import Firebase

struct PasswordResetView: View {
    @State private var email: String = ""
    @State private var resetError: Error? = nil
    @State private var isShowingAlert: Bool = false
    
    @Environment (\.dismiss) var dismiss

    @Environment(\.presentationMode) var presentationMode // Added this line to access presentationMode

    
    var body: some View {
        NavigationView {
            
            ZStack (alignment: .top){
                
                
                    Color("Logoblue")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        // Image
                        Image("Logo3")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 100)
                            .padding(.bottom, 10)
                        
                        // Email Field
                        VStack(spacing: 0) {
                            InputView(text: $email,
                                      title: "Email Address",
                                      placeholder: "name@example.com")
                            .autocapitalization(.none)
                            .padding(.horizontal)
                            .padding(.bottom)
                        }
                        .padding(.top, 2)
                        .padding(.bottom, 25)
                        
                        // Reset Password Button
                        Button {
                            resetPassword()
                            
                            
                            
                        } label: {
                            HStack {
                                Text("Send Reset To Email")
                                    .fontWeight(.semibold)
                                Image(systemName: "arrow.right")
                            }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                            .background(Color(.systemBlue))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .alert(isPresented: $isShowingAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(resetError?.localizedDescription ?? "Unknown error"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    
                    VStack{

                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {HStack(spacing: 3){
                        Text("Back to")
                            .foregroundColor(.white)
                        Text("Login")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                    }
                    }
                    .font(.system(size:18))
                    
                }
            }
        }
    }
    
    func resetPassword() {
        Task {
            do {
                try await Auth.auth().sendPasswordReset(withEmail: email)
                // Password reset email sent successfully
                // You may navigate to another screen or show a success message here
                print("Password reset email sent successfully!")
                
                // Navigate back to the LoginView
                presentationMode.wrappedValue.dismiss()
            } catch {
                // Handle the password reset error
                resetError = error
                isShowingAlert = true
            }
        }
    }
}
    
    






struct ForgotPassword_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView().environmentObject(AuthViewModel())
    }
}
