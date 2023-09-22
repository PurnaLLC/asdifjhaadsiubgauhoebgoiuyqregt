import SwiftUI

struct AnimationsView: View {
    @State private var counter: Int = 0
    @State private var isBreathingIn: Bool = true
    @State private var animateBreathing: Bool = false
    @State private var rotation: Double = 0
    @State private var scale1: CGFloat = 0.7
    @State private var scale2: CGFloat = 0.55
    @State private var scale3: CGFloat = 0.4
    
    let height: CGFloat = UIScreen.main.bounds.height
    let width: CGFloat = UIScreen.main.bounds.width
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            ZStack {
                NonagonView(scale: $scale1, duration: 1, color: Color.blue, breathIn: isBreathingIn)
                NonagonView(scale: $scale2, duration: 0.95, color: Color.red, breathIn: isBreathingIn)
                NonagonView(scale: $scale3, duration: 0.9, color: Color.yellow, breathIn: isBreathingIn)
            }
            .rotationEffect(.degrees(rotation))
            .onReceive(timer) { _ in
                if animateBreathing {
                    self.handleBreathing()
                }
            }
            
            Text("Breaths in: \(counter)")
                .font(.title)
                .padding()
            
            Button("touch me just like that") {
                animateBreathing = true
            }
            .padding()
        }
        .onReceive(timer) { _ in
            if animateBreathing {
                withAnimation(Animation.easeInOut(duration: 2)) {  // Animation duration should match your timer interval
                    self.rotation += 20
                    self.handleBreathing()
                }
            }
        }
    }
    
    func handleBreathing() {
        if self.isBreathingIn {
            withAnimation(Animation.easeInOut(duration: 2).delay(0.5)) {
                self.breatheOut()
            }
        } else {
            withAnimation(Animation.easeInOut(duration: 2).delay(0.5)) {
                self.breatheIn()
            }
        }
        isBreathingIn.toggle()
        counter += 1
    }

    
    func breatheIn() {
        scale1 = 1.2
        scale2 = 1.0
        scale3 = 0.8
    }
    
    func breatheOut() {
        scale1 = 0.2
        scale2 = 0.2
        scale3 = 0.2
    }
}
    struct NonagonView: View {
        @Binding var scale: CGFloat
        let duration: Double
        let color: Color
        let breathIn: Bool
        
        var body: some View {
                Nonagon(rotationAngle: .degrees(10), cornerRoundness: 0.1)
                    .fill(color)
                    .scaleEffect(breathIn ? scale : 1.0)
                    .animation(nil)
                    .scaleEffect(!breathIn ? scale : 1.0)
                    .animation(.easeInOut(duration: duration))
            }
        }

    
    struct Nonagon: Shape {
        var rotationAngle: Angle
        var cornerRoundness: CGFloat = 0.0
        
        func path(in rect: CGRect) -> Path {
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) * 0.5
            let angleStep = Double.pi * 2 / 9
            let adjustment: CGFloat = cornerRoundness * CGFloat(angleStep/2)
            
            var path = Path()
            
            for i in 0..<9 {
                let angle = angleStep * Double(i) - rotationAngle.radians
                
                let outerX = center.x + radius * CGFloat(cos(angle))
                let outerY = center.y + radius * CGFloat(sin(angle))
                
                let prevAngle = angle - adjustment
                let nextAngle = angle + adjustment
                
                let prevX = center.x + radius * CGFloat(cos(prevAngle))
                let prevY = center.y + radius * CGFloat(sin(prevAngle))
                
                let nextX = center.x + radius * CGFloat(cos(nextAngle))
                let nextY = center.y + radius * CGFloat(sin(nextAngle))
                
                if i == 0 {
                    path.move(to: CGPoint(x: prevX, y: prevY))
                } else {
                    path.addLine(to: CGPoint(x: prevX, y: prevY))
                }
                path.addQuadCurve(to: CGPoint(x: nextX, y: nextY), control: CGPoint(x: outerX, y: outerY))
            }
            path.closeSubpath()
            
            return path
        }
    }
    
    
    
    struct AnimationCompletion: AnimatableModifier {
        var fractionCompleted: CGFloat = 0
        
        var animatableData: CGFloat {
            get { fractionCompleted }
            set { fractionCompleted = newValue }
        }
        
        var onCompletion: () -> Void
        
        func body(content: Content) -> some View {
            if fractionCompleted == 1 {
                DispatchQueue.main.async {
                    self.onCompletion()
                }
            }
            return content
        }
    }

extension View {
    func onAnimationCompleted(_ onCompletion: @escaping () -> Void) -> some View {
        modifier(AnimationCompletion(onCompletion: onCompletion))
    }
}

struct AnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsView()
    }
}
