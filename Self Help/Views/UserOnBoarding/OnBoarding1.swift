//
//  OnBoarding1.swift
//  Self Help
//
//  Created by Maxwell Meyer on 8/31/23.
//

import SwiftUI
import Combine

class SearchBarViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var finishedText: String = ""
}

struct OnBoarding1: View {
    
    @State private var isShowingGender: Bool = false
    @StateObject private var vm = SearchBarViewModel()
    @State private var isShowingFinishedButton: Bool = false
    
    var body: some View {
        NavigationView{
            VStack {
                VStack {
                    Text("What should daddy call you")
                    
                    InputView(text: $vm.username,
                              title: " ",
                              placeholder: "Name/Nick Name")
                    
                    .frame(width: 300)
                    .onReceive(
                        vm.$username
                            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                    ) { newText in
                        if !newText.isEmpty {
                            print(">> searchin g for: \(newText)")
                            isShowingGender = true
                        } else {
                            isShowingGender = false
                            isShowingFinishedButton = false
                        }
                    }
                    
                    if isShowingGender {
                        Text("What gender")
                        
                        InputView(text: $vm.finishedText,
                                  title: " ",
                                  placeholder: "")
                        
                        .frame(width: 300)
                        .onReceive(
                            vm.$finishedText
                                .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
                        ) { finishedText in
                            if !finishedText.isEmpty {
                                print(">> searching for: \(finishedText)")
                                isShowingFinishedButton = true // Show the finished button
                            } else {
                                isShowingFinishedButton = false
                            }
                        }
                    }
                    
                    if isShowingFinishedButton {
                        VStack {
                            NavigationLink {
                                // destination view to navigation to
                                OnBoarding2(name: vm.username)
                            }  label: {
                                Text("Jack is sus")
                            }
                        }
                    }
                }
            }
        }
    }
}


struct OnBoarding1_Previews: PreviewProvider {
    static var previews: some View {
        OnBoarding1()
    }
}
