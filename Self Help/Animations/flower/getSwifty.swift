//
//  ContentView.swift
//  BreathingAnimation
//
//  Created by Alexandru Turcanu on 19/03/2020.
//  Copyright © 2020 CodingBytes. All rights reserved.
//

import SwiftUI

struct getSwifty: View {
    @State private var numberOfPetals: Double = 5
    @State private var isMinimized = false
    @State private var animationDuration = 4.2
    @State private var loopCount: Int = 0
    @State private var breathDuration = 4.2
    let maxLoopCount: Int = 5
    
    private var fadeDuration: Double {
        return breathDuration * 0.6
    }

    func playAnimation() {
            self.animationDuration = self.breathDuration
            self.isMinimized.toggle()

            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration) {
                self.isMinimized.toggle()
            }
        }
    
    

    func loopAnimation() {
          guard loopCount < maxLoopCount else {
              print("Completed all loops!")
              return
          }

        playAnimation()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2 * animationDuration) {
                loopCount += 1
                loopAnimation()
            }
        }

    
    
    
    
    
    
    
    
    var body: some View {
        List {
            Section {
                // Flower
                ZStack {
                    
                    if !isMinimized { // second lil' hack
                        FlowerView(isMinimized: $isMinimized,
                                   numberOfPetals: $numberOfPetals,
                                   animationDuration: $animationDuration
                        ).transition(
                            AnyTransition.asymmetric(
                                insertion: AnyTransition.opacity.animation(Animation.default.delay(animationDuration)),
                                removal: AnyTransition.blurFade.animation(Animation.easeIn(duration: fadeDuration))
                            )
                            /**
                             General Observation - use real devices for best results
                             Asymmetric Transitions are sometimes buggy, this includes:
                                - animationDuration is not always updated prior to a change
                                - the removal transition is used for an insertion
                             */
                        )
                    }

                    // This FlowerView creates a mask around the Main FlowerView
                    FlowerView(isMinimized: $isMinimized,
                               numberOfPetals: $numberOfPetals,
                               animationDuration: $animationDuration,
                               color: Color(UIColor.black)
                    )

                    // Main FlowerView
                    FlowerView(isMinimized: $isMinimized,
                               numberOfPetals: $numberOfPetals,
                               animationDuration: $animationDuration)
                }

                // align the flower nicely
                .frame(maxWidth: .infinity)
                .padding(.vertical, 64)
            }
    
            
            // Number of Petals
            Section(header: Text("Number of Petals: \(Int(numberOfPetals))")) {
                Slider(value: $numberOfPetals, in: 2...10) { onEditingChanged in
                    // detect when interaction with the slider is done and engage snapping to the closest petal
                    if !onEditingChanged {
                        numberOfPetals = numberOfPetals.rounded()
                    }
                }
            }
            Section{
                Button {
                    self.playAnimation()
                } label: {
                    Text("i love max and he doesn't even know uwu")
                }

            }
                   
            // Breathing Duration
            Section(header: Text("Breathing Duration: \(breathDuration)")) {
                Slider(value: $breathDuration, in: 0...10, step: 0.1)
            }

        }
        .listStyle(InsetGroupedListStyle())
        .environment(\.colorScheme, .dark)
        .onAppear{
            self.loopAnimation()
        }
        
    }
    
}

extension AnyTransition {
    static var blurFade: AnyTransition {
        get {
            AnyTransition.modifier(
                active: BlurFadeModifier(isActive: true),
                identity: BlurFadeModifier(isActive: false)
            )
        }
    }
}

struct BlurFadeModifier: ViewModifier {
    let isActive: Bool

    func body(content: Content) -> some View {
        content
            .scaleEffect(isActive ? 1.5 : 1)
            .blur(radius: isActive ? 8 : 0)
            .opacity(isActive ? 0 : 0.7)
    }
}


struct getSwifty_Previews: PreviewProvider {
    static var previews: some View {
        getSwifty()
            .environment(\.colorScheme, .dark)
    }
}
