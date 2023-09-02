//
//  Home.swift
//  Wordz
//
//  Created by Maxwell Meyer on 6/12/23.
//

import SwiftUI


struct Home: View {
    @State private var activeTab: Tab = .calendar
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
    init() {
        /// Hiding Tab Bar Due To SwiftUI iOS 16.4 Bug
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                
                
                ChatView().environmentObject(AuthViewModel())
                    .tabItem {
                        Image(systemName: Tab.chatview.systemImage)
                        Text(Tab.chatview.rawValue)
                        
                    }
                    .tag(Tab.chatview)
                
                Breathe()
                    .tabItem {
                        Image(systemName: Tab.breathe.systemImage)
                        Text(Tab.breathe.rawValue)
                    }
                    .tag(Tab.breathe)
                
                
                CalendarView()
                    .tabItem {
                        Image(systemName: Tab.calendar.systemImage)
                        Text(Tab.calendar.rawValue)
                    }
                    .tag(Tab.calendar)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: Tab.profiletab.systemImage)
                        Text(Tab.profiletab.rawValue)
                    }
                    .tag(Tab.profiletab)
            }
            .accentColor(Color("Logoblue")) // Set the active tab color
            
            CustomTabBar()
        }
    }
    
    // Custom tab bar
    @ViewBuilder
    func CustomTabBar(_ tint: Color = .black, _ inactiveTint: Color = .black) -> some View {
      
        HStack(alignment: .bottom, spacing: 0) {
            TabItem(
                tint: tint,
                inactiveTint: inactiveTint,
                tab:.chatview,
                animation: animation,
                activeTab: $activeTab,
                position: $tabShapePosition
            )
            
            
            TabItem(
                tint: tint,
                inactiveTint: inactiveTint,
                tab:.breathe,
                animation: animation,
                activeTab: $activeTab,
                position: $tabShapePosition
            )
            
            TabItem(
                tint: tint,
                inactiveTint: inactiveTint,
                tab: .calendar,
                animation: animation,
                activeTab: $activeTab,
                position: $tabShapePosition
            )
            TabItem(
                tint: tint,
                inactiveTint: inactiveTint,
                tab: .profiletab,
                animation: animation,
                activeTab: $activeTab,
                position: $tabShapePosition
            )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, -10)
        .padding(.bottom, 0)
        .background(content: {
            Rectangle()
                .fill(.white)
                .ignoresSafeArea()
                .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -15)
                .blur(radius: 2)
                // Add negative padding to remove the gap
        })
        .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
    }
}

struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.system(size: activeTab == tab ? 24 : 20))
                .foregroundColor(activeTab == tab ? .black : inactiveTint)
                .frame(width: activeTab == tab ? 58 : 45, height: activeTab == tab ? 58 : 45)
                .fixedSize()
                .background {
                    if activeTab == tab {
                    
                    }
                }
            
            Text(tab.rawValue)
                .font(.custom("Lora-Regular", size: 15))
                .bold()
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            position.x = rect.midX
            
            if activeTab == tab {
                position.x = rect.midX
            }
        })
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = position.x
            }
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(AuthViewModel())
            .background(HelperView())   // << here !!
    }
}
