//
//  TabModel.swift
//  Wordz
//
//  Created by Maxwell Meyer on 6/12/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case calendar = "Calendar"
    
    case chatview = "Home"
    case profiletab = "Profile"
    
    case breathe = "Breathe"
    
    var systemImage: String {
        switch self {
        case .calendar:
            return "calendar"
        case .chatview:
            return "house"
        case .profiletab:
            return "person.crop.circle"
            
        case .breathe:
            return "lungs"
            
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

