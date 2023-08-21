//
//  GoogleSiginBtn.swift
//  SignInUsingGoogle
//
//  Created by Swee Kwang Chua on 12/5/22.
//

import SwiftUI

struct GoogleSiginBtn: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
        HStack{
                
                Image("google")
                
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    
            Text ("Sign in with Google")
                .foregroundColor(Color(.black))
                    
            }
        .frame(width: 350, height: 50, alignment: .center)

     

        }
        .background(Color(.white))
        .cornerRadius(10)

        
    }
}

struct GoogleSiginBtn_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSiginBtn(action: {})
            .background(HelperView())   // << here !!
    }
}
