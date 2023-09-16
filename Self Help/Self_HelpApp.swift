//
//  Self_HelpApp.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/20/23.
//


import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import Combine





@main
struct Self_HelpApp: App {
    
    
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @AppStorage("signIn") var isSignIn = false
    
    @AppStorage("log_status") var log_Status = false
    
    @StateObject var viewModel = AuthViewModel()


    
    @StateObject var singinViewmodel = SinginViewModel()
 
    init () {
        FirebaseApp.configure()
        let db = Firestore.firestore()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentsView()
     //           .environmentObject(viewModel)
             //   .modelContainer(for: Word.self)
                .environmentObject(viewModel)
                .environmentObject(singinViewmodel)
                .background(HelperView())   // << here !!
            
        }
      
    }
  
}





struct HelperView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        OrientationHandler()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }

    class OrientationHandler: UIViewController {
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            coordinator.animate(alongsideTransition: nil) { _ in
                UIView.setAnimationsEnabled(true)
            }
            UIView.setAnimationsEnabled(false)
            super.viewWillTransition(to: size, with: coordinator);
        }
    }
}


