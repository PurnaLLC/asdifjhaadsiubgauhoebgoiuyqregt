//
//  Video.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/15/23.
//

import SwiftUI
import AVKit




struct Video: View {
    var body: some View {
        
        ZStack{
            LoopingPlayer()
        }
        .edgesIgnoringSafeArea(.all)

       
    }
}

struct Video_Previews: PreviewProvider {
    static var previews: some View {
        Video()
    }
}
