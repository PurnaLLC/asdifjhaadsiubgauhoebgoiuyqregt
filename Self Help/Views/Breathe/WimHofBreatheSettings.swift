//
//  WimHofBreatheSettings.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/25/23.
//

import SwiftUI

enum previewWimHofBreatheText {
    case breatheIn
    case breatheOut
    case holdStart
    case holdEnd

}



   

    @available(iOS 14.0, *)
    struct WimHofBreatheSettings: View {
        @State private var numberOfPetals: Double = 7
        
        @State private var isMinimized = true
        @State private var animationDuration = petalDuration
        
        /// Duration of the breathing animation
        @State private var breathDuration = 4.2
        
        /// Duration of addition/removal animation for petals
        static let petalDuration = 0.5
        
        /// Duration of the BlurFade transition based on the **breathingAnimation**
        
         var fadeDuration: Double {
            return breathDuration * 0.6
            
        }
        
        
        
        
        @State private var isshowingloopinganimation = false
        
        
        @State  var breathInHold: Int
        
        @State  var breathOutHold: Int
        
        
        @State  var breathOutDuration: Int
        
        @State  var breathInDuration: Int
        

        
      /*  6/8
        
        5/7
        
        4/6
        
        3/5
        
        2/4
       */

        
        @State private var currentBreathe: breatheText = .holdStart
        
        
        
        @State var vm = BreatheClockViewModel()
        
        
        @State private var timer = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .common).autoconnect()
        
        @State private var isCounting = false
        
        @State  var maxBreathCount: Int //30
        @State  var DoubleMaxBreathCount: Double // 30
        @State  var previousTotalBreatheDuration: Double  //10
        @State  var previewsTotalBreatheSession: Double  //30
        @State  var totalBreatheDuration: Double // 10
        @State  var totalBreatheSession: Double  //300
        @State  var previousMaxBreathCount: Double //30

        
        
        
        @State var breath30HoldOut: Int
        
        @State var breath30HoldIn: Int

        
        @State var breath30HoldIndex:Int
        
        
        @State  var previousDouble30Hold: Double  //30
        @State  var Double30hold: Double // 10
        
        
        
        
        @State private var breathcount = 0
        
        
        var body: some View {
            NavigationView{
                
                
                VStack {
                    
                    Text("REFLECTO")
                    
                    Text("Comes from fake langauge")
                    
                    
                    
                    switch currentBreathe {
                    case .breatheIn:
         //                   Text("Breathe In")
          //                  .font(.system(size: 40))
                        
                        
                        Text("")
                        
                        
                        
                    case .breatheOut:
         //                   Text("Breathe Out")
         //                   .font(.system(size: 40))
                        
                        
                        Text("")
                        
                        
                        
                        
                        
                    case .holdStart:
         //                   Text("Hold")
          //                 .font(.system(size: 40))
                        
                        
                        
                        
                        Text("")
                        
                        
                        
                        
                    case .holdEnd:
       //                 Text("Hold")
         //                   .font(.system(size: 40))
                        
                        Text("")
                        
                        
                        
                    }
                    
                    
                    
                    Section {
                        // Flower
                        ZStack {
                            if !isMinimized { // second lil' hack
                                
                                
                                FlowerView(isMinimized: $isMinimized,
                                           numberOfPetals: $numberOfPetals,
                                           animationDuration: $animationDuration, circleDiameter: 100
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
                                       animationDuration: $animationDuration, circleDiameter: 100 ,
                                       color: Color(UIColor.black)
                            )
                            
                            
                            
                            
                            // Main FlowerView
                            FlowerView(isMinimized: $isMinimized,
                                       numberOfPetals: $numberOfPetals,
                                       animationDuration: $animationDuration, circleDiameter: 100)
                            
                            
                            Text("\(breathcount)")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                            
                            
                        }
                        
                        // align the flower nicely
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 50)
                    }
                    
                    
                    
                    
                    .onAppear{
                        
                        infiniteloop()
                        
                    }
                    
                    
                    
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(.white)
                    .listRowBackground(Color(UIColor.black))
                    
                    
         
                    
       
                    
                    Section(header: Text("Breathe Speed: \(totalBreatheDuration) seconds")) {
                        Slider(value: $totalBreatheDuration, in: (2)...(4), step: (1))
                    }
                    
                    .onChange(of: totalBreatheDuration) { newValue in
                        if newValue == previousTotalBreatheDuration + 1 {
                            
                            
                            self.breathInHold += 0
                            
                            self.breathOutDuration += Int(round(0.5))

                            
                         
                            
                            self.breathInDuration += Int(round(0.5))



                            self.breathOutHold += 0
                            
                            self.totalBreatheSession = Double(((self.breathInHold + self.breathOutDuration + self.breathInDuration + self.breathOutHold) * self.maxBreathCount) + (breath30HoldIndex * (self.breath30HoldOut + self.breath30HoldIn )))
                            
                          
                        } else if newValue == previousTotalBreatheDuration - 1 {
                            // Value decreased by one

                            
                            
                            self.breathInHold += 0
                            
                            self.breathOutDuration -= Int(round(0.5))
                            print("\(breathOutDuration)")
                            self.breathInDuration -= Int(round(0.5))
                            print("\(breathInDuration)")

                            self.breathOutHold += 0
                            
                            self.totalBreatheSession = Double(((self.breathInHold + self.breathOutDuration + self.breathInDuration + self.breathOutHold) * self.maxBreathCount) + ( breath30HoldIndex * (self.breath30HoldOut + self.breath30HoldIn )))
                            
                     

                        }
                        
                        // Update the previous value
                        previousTotalBreatheDuration = newValue
                    }
                    
                 
                    
                    
                    Text("Session Duration: \(totalBreatheSession) seconds")
                    
                    Section(header: Text("Number of Breathes Per Session: \(DoubleMaxBreathCount)")) {
                        Slider(value: $DoubleMaxBreathCount, in: 60...120, step: 30)
                        
                        
                        
                        
                    }
                    .onChange(of: DoubleMaxBreathCount) { newValue in
                        if newValue == previousMaxBreathCount + 30 {
                            
                       
                            
                            self.maxBreathCount += 30
                            self.breath30HoldIndex += 1
                            
                            
                            
                            print ("\(self.maxBreathCount )")

                            
                             
                            self.totalBreatheSession = Double(((self.breathInHold + self.breathOutDuration + self.breathInDuration + self.breathOutHold) * self.maxBreathCount) + ( breath30HoldIndex * (self.breath30HoldOut + self.breath30HoldIn )))
                            
                            // Value increased by one
                            print("Value increased by one")
                        } else if newValue == previousMaxBreathCount - 30 {
                            // Value decreased by one
                            self.breath30HoldIndex -= 1
                            
                            
                            self.maxBreathCount -= 30
                            
                            print ("\(self.maxBreathCount )")
                            
                            self.totalBreatheSession = Double(((self.breathInHold + self.breathOutDuration + self.breathInDuration + self.breathOutHold) * self.maxBreathCount) + (breath30HoldIndex * (self.breath30HoldOut + self.breath30HoldIn )))
                            
                            
                            
                            
                            
                            print("sus down ")
                        }
                        
                        // Update the previous value
                        previousMaxBreathCount = newValue
                    }
                    
                    
                    
                    
                    
                    
                    
                    Section(header: Text("Hold length \(Double30hold) seconds")) {
                        Slider(value: $Double30hold, in: 60...120, step: 30)
                        
                        
                        
                        
                    }
                    .onChange(of: Double30hold) { newValue in
                        if newValue == previousMaxBreathCount + 30 {
                            
                            
                            self.breath30HoldOut += 30
                            
                  
                            
                            
                            self.totalBreatheSession = Double(((self.breathInHold + self.breathOutDuration + self.breathInDuration + self.breathOutHold) * self.maxBreathCount) + (breath30HoldIndex * (self.breath30HoldOut + self.breath30HoldIn )))
                            
                            
                            
                        } else if newValue == previousMaxBreathCount - 30 {
                            // Value decreased by one
                            
                            
                            
                            self.breath30HoldOut -= 30
                            
                            self.totalBreatheSession = Double(((self.breathInHold + self.breathOutDuration + self.breathInDuration + self.breathOutHold) * self.maxBreathCount) + (breath30HoldIndex * (self.breath30HoldOut + self.breath30HoldIn )))
                            
                        }
                            // Update the previous value
                            previousDouble30Hold = newValue
                        
                        
                        
                    }
                    
                 

                    
                    NavigationLink {
                        WimHofBreathAnimationView(breathInHold: self.breathInHold, breathOutHold: self.breathOutHold, breathOutDuration: self.breathOutDuration, breathInDuration: Int(self.breathInDuration),  breath30HoldOut: self.breath30HoldOut, breath30HoldIn: self.breath30HoldIn, maxBreathCount: Int(self.maxBreathCount))
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Begin")
                        
                    }

                    
                    
                    
                    
                    
                }
                .onReceive(timer) { _ in
                    // Update the countdown timer
                    if isCounting {
                        vm.decrement()
                        if vm.minutes == 0 && vm.seconds == 0 {
                            // Countdown finished
                            isCounting = false
                            timer.upstream.connect().cancel()
                        }
                    }
                }
                
                
            }
        }
            
            
            func infiniteloop(){
                
                
                currentBreathe = .holdStart
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 + TimeInterval(self.breathOutHold)) {
                    
                    
                    
                    
                    currentBreathe = .breatheIn
                    //animation is start by changin is minimized and sets the duration of the out length
                    
                    self.animationDuration = Double(self.breathInDuration)
                    isMinimized = false
                    
                    
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() +  TimeInterval(self.breathInDuration)  ) {
                        currentBreathe = .holdEnd
                        
                        
                        
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() +  TimeInterval(self.breathInDuration) + TimeInterval(self.breathInHold)  ) {
                        self.isMinimized = true
                        self.animationDuration  = Double(self.breathOutDuration)
                        
                        
                        currentBreathe = .breatheOut
                        
                    }
                    
                    
                    
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() +  TimeInterval(self.breathInDuration) +  TimeInterval(self.breathOutDuration)   + TimeInterval(self.breathInHold) +   TimeInterval(self.breathOutHold) ) {
                    
                    
                    
                    if breathcount < Int(maxBreathCount){
                        infiniteloop()
                        
                        breathcount += 1
                        
                        
                        
                    }else{
                        
                    }
                    
                    
                    
                }
                
            }
            
            
        
    }


    /*

    @available(iOS 14.0, *)
    struct SettingsForBreatheAnimationView_Previews: PreviewProvider {
        static var previews: some View {
            SettingsForBreatheAnimationView(breathInHold: 0, breathOutHold: 0, breathOutDuration: 4, breathInDuration: 6)
        }
    }
     */
