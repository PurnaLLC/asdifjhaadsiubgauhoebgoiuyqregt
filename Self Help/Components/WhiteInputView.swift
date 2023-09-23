//
//  WhiteInputView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/15/23.
//

import SwiftUI

struct WhiteInputView: View {
    @Binding var text:String
    let title: String
    let placeholder: String

    
    var body: some View {
        VStack (alignment: .leading, spacing: 12){
            Text(title)
                .font(.system(size: 18))
                .foregroundColor(Color(.white))
                .fontWeight(.semibold)
                .font(.footnote)
                .textContentType(.username)
            
                
            
         
                TextField(placeholder, text: $text)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .textContentType(.username)
           
            
            Divider()
            
        }
    }
}


