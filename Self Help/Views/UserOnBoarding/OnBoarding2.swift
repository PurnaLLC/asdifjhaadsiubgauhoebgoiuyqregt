//
//  OnBoarding2.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/31/23.
//

import SwiftUI

struct OnBoarding2: View {
    @State var username: String
    var body: some View {
        Text("What are you going threw \(username)")
    }
}

struct OnBoarding2_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding2(username: "")
    }
}
