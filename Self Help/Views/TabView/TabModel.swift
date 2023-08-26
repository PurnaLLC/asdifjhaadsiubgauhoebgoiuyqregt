//
//  TabModel.swift
//  Wordz
//
//  Created by Maxwell Meyer on 6/12/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case wordofthedaytab = "Calender"
    
    case chatview = "Home"
    case profiletab = "Profile"
    
    var systemImage: String {
        switch self {
        case .wordofthedaytab:
            return "sun.max"
        case .chatview:
            return "house"
        case .profiletab:
            return "person.crop.circle"
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}

