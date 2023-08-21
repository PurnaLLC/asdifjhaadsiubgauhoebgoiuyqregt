//
//  InputView.swift
//  Wordz
//
//  Created by Maxwell Meyer on 6/6/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text:String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(Color(.black))
                .fontWeight(.semibold)
                .font(.footnote)
                .textContentType(.username)
                
            
            if isSecureField{
                SecureField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .textContentType(.username)
                   
            }else{
                TextField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .textContentType(.username)
                    
            }
            
            Divider()
            
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
    }
}
