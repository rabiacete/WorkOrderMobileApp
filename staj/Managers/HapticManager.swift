// 
//  HapticManager.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

class HapticManager {
    
    static func generate(feedback: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: feedback)
        generator.impactOccurred()
    }
    
    static func generate(notification: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(notification)
    }
}
