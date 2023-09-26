//
//  WimHofBreathAnimationView.swift
//  Self Help
//
//  Created by Maxwell Meyer on 9/25/23.
//

import SwiftUI



enum wimHofBreatheText {
    case breatheIn
    case breatheOut
    case holdStart
    case holdEnd

}





/*
//value 2

Text(vm.formattedTime)



    .onAppear{
        if isCounting {
            // Stop the countdown
            timer.upstream.connect().cancel()
        } else {
            // Start or resume the countdown
            vm.startCountdown(from: self.breathInHold)
            timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
        }
        isCounting.toggle()

        DispatchQueue.main.asyncAfter(deadline: .now() +  TimeInterval(self.breathInHold)) {
            vm.reset()

        }
    }
 
 
 */




struct WimHofBreathAnimationView: View {
    @State private var numberOfPetals: Double = 7
    
    @State private var isMinimized = true
    @State private var animationDuration = petalDuration
    
    /// Duration of the breathing animation
    @State private var breathDuration = 4.2
    
    /// Duration of addition/removal animation for petals
    static let petalDuration = 0.5
    
    /// Duration of the BlurFade transition based on the **breathingAnimation**
    
    private var fadeDuration: Double {
        return breathDuration * 0.6
        
    }
    
    
    
    
    @State private var isshowingloopinganimation = false
    
    
    @State  var breathInHold: Int

    @State  var breathOutHold: Int
    
    
    @State  var breathOutDuration: Int
    
    @State  var breathInDuration : Int
    
    
    @State private var breathcount = 0
    
    @State private var currentBreathe: breatheText = .holdStart
    
    
    
    
    
    @State private var timer = Timer.TimerPublisher(interval: 1.0, runLoop: .main, mode: .common).autoconnect()
    
    @State private var isCounting = false
    
    
    @State var breath30HoldOut: Int
    
    @State var breath30HoldIn: Int

    
    @State  var maxBreathCount: Int
    
    var body: some View {
        
        
        VStack {
            switch currentBreathe {
            case .breatheIn:
                Text("Breathe In")
                    .font(.system(size: 40))
                
                
                
                
            case .breatheOut:
                Text("Breathe Out")
                    .font(.system(size: 40))
                
            
                
                
                
                
            case .holdStart:
                
                
                if self.breathOutHold == 0 {
                    
                    
                    Text("Breath Out")
                        .font(.system(size: 40))

                }else{
                    
                    
                    Text("Hold")
                        .font(.system(size: 40))
                    
                }
                
                
                
             
                
            case .holdEnd:
                
     //           if self.breathInHold == 0 {
                    
     //               Text("Breath In")
    //                    .font(.system(size: 40))
       //         }else{
     
                    
                    Text("Hold")
                        .font(.system(size: 40))
                    
       //         }
                
                
                
            }
            
            
            
            Section {
                // Flower
                ZStack {
                    if !isMinimized { // second lil' hack
                        
                        
                        FlowerView(isMinimized: $isMinimized,
                                   numberOfPetals: $numberOfPetals,
                                   animationDuration: $animationDuration, circleDiameter: 150
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
                               animationDuration: $animationDuration, circleDiameter: 150 ,
                               color: Color(UIColor.black)
                    )
                    
                    
                    
                    
                    // Main FlowerView
                    FlowerView(isMinimized: $isMinimized,
                               numberOfPetals: $numberOfPetals,
                               animationDuration: $animationDuration, circleDiameter: 150)
                    
                    
                    Text("\(breathcount)")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    
                    
                }
                
                // align the flower nicely
                .frame(maxWidth: .infinity)
                .padding(.vertical, 50)
            }
            
            
            
            
            .onAppear{
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    
                    
                    infiniteloop()
                    
                }
                
            }
            
            
            
            
            
            
            
            
            
            
            .buttonStyle(BorderlessButtonStyle())
            .foregroundColor(.white)
            .listRowBackground(Color(UIColor.black))
            
            
            
        }
        
        /*
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
        
        */
        
        
        
    }
    
    
    
    func infiniteloop(){
        
        
        currentBreathe = .holdStart
        
        
        print ("\(self.breathInDuration)")
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(self.breathOutHold)) {
            
            
            
            
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

            
            
            if breathcount < maxBreathCount{
                
                if breathcount == 30{
                    
                    breathHold()
                    
                }else{
                    
                    

                        if breathcount == 60{
                            
                            breathHold()
                            
                        }else{
                            
                            
                       
                                
                                if breathcount == 90{
                                    
                                    breathHold()
                                    
                                }else{
                                    
                                    if breathcount == 120{
                                        
                                     
                                        
                                        breathHold()
                                        
                                    }else{
                                        
                                        
                                        infiniteloop()
                                        
                                        breathcount += 1
                                        
                                    }
                        }
                    }
                }
                
                
                
            }else{
                
            }
            
            
            
        }
        
    }


    func breathHold(){
        
        currentBreathe = .holdEnd
        
        
        isMinimized = true
            
        
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() +  TimeInterval(breath30HoldOut) ) {
            
            isMinimized = false
            
            currentBreathe = .breatheIn
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() +  TimeInterval(self.breathInDuration) ) {
                
                currentBreathe = .holdEnd
                
                
                
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() +  TimeInterval(breath30HoldIn) ) {
                    
                    isMinimized = true
                    
                    currentBreathe = .breatheOut
                    
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() +  TimeInterval(self.breathOutDuration) ) {
                        infiniteloop()
                        breathcount += 1
                        
                    }
                    
                }
                
                
                
                
            }
            
            
            
            
        }
        
        
        
        
        
    
    
    
    
}


        
        
    }
    
    













struct WimHofBreathAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        WimHofBreathAnimationView(breathInHold: 0, breathOutHold: 0, breathOutDuration: 2, breathInDuration: 2, breath30HoldOut: 90, breath30HoldIn: 150, maxBreathCount: 30)
    }
}
