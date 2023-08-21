//
//  FirebAuth.swift
//  SignInUsingGoogle
//
//  Created by Swee Kwang Chua on 12/5/22.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Firebase
import SwiftUI

struct FirebAuth {
    
    @EnvironmentObject var viewModel: AuthViewModel

    static let share = FirebAuth()
    
    private init() {}
    
    func signinWithGoogle(presenting: UIViewController,
                          completion: @escaping (Error?, Bool) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: presenting) { user, error in
            
            if let error = error {
                completion(error, false) // Call completion with error and false
                return
            }
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else {
                completion(nil, false) // Call completion with no error and false
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { _, error in
                if let error = error {
                    completion(error, false) // Call completion with error and false
                    return
                }
                
                print("SIGN IN")
                UserDefaults.standard.set(true, forKey: "signIn")
                completion(nil, true) // Call completion with no error and true for success
            }
        }
    }

    
    
}


