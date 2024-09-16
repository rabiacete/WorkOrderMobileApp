// 
//  TabbarDataProvider.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

class TabbarDataProvider {
    
    static let shared = TabbarDataProvider()
    
    func provideTabbarItems() -> [TabbarModel] {
            return TabbarScene.allCases.map { scene in
                return TabbarModel(title: scene.title, icon: scene.icon, controller: scene.scene.controller)
            }
        }
}

enum TabbarScene {
    
    static let allCases: [TabbarScene] = [.tab1, .tab2, .tab3]
    
    case tab1
    case tab2
    case tab3
    
    var title: String {
        switch self {
        case .tab1:
            return "Tab1"
        case .tab2:
            return "Tab2"
        case .tab3:
            return "Tab3"
        }
    }
    
    var icon: Images {
        switch self {
        case .tab1:
            return .tab1
        case .tab2:
            return .tab2
        case .tab3:
            return .tab3
        }
    }
    
    var scene: Scenes {
        switch self {
        case .tab1:
            return .tab1
        case .tab2:
            return .tab2
        case .tab3:
            return .tab3
        }
    }
}
struct TabbarModel {
    let title: String
    let icon: Images
    let controller: UIViewController
}
