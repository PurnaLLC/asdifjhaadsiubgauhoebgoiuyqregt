//
//  SinginViewMOdel.swift
//  TodolistFB
//
//  Created by youssef on 2022-11-27.
//
import SwiftUI
import Foundation
import Firebase
import CryptoKit
import FirebaseFirestore
import AuthenticationServices
class SinginViewModel:ObservableObject{
    
    @EnvironmentObject var viewModel: AuthViewModel

    @Published var nonce = ""
    @Published var done = false
    
    
    
    
    func SinginWithAppleRequest(_ request: ASAuthorizationOpenIDRequest){
        nonce = randomNonceString()
        request.requestedScopes = [.fullName,.email]
        request.nonce = sha256(nonce)
    }
    func SinginWithAppleCompletion( _ result: Result<ASAuthorization,Error>, selectedProblems: [String],userGender: String,  userName: String){
        switch result {
        case .success(let user):
            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
              print("credential 23")
                return
            }
            guard let token = credential.identityToken else{
                print("error with token 27")
                return
            }
            guard let tokenString = String(data: token, encoding: .utf8) else{
                print("error with tokenString 31")
                return
            }
            let credwtion = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
            
            Task {
                do{
                    try await Auth.auth().signIn(with: credwtion)
                    DispatchQueue.main.async {
                        
                        Task {
                            do {
                                try await self.viewModel.createGmailUser(fullname: "", userSelectedProblems: selectedProblems ,userGender: userGender ,userName: userName)
                                // TODO: Navigate to Home view
                            } catch {
                                // TODO: Handle error from createUser
                            }
                            
                        }
                    }
                    
                    
                    
                }catch{
                    print("error 45")
                }
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    
    
}
private func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    String(format: "%02x", $0)
  }.joined()

  return hashString
}

 func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}


