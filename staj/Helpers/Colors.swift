// 
//  Colors.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

enum Colors: String {
    case backgroundColor = "backgroundColor"
    case titleColor = "titleColor"
    case captionColor = "captionColor"
    case primaryColor = "primaryColor"
    case secondaryColor = "secondaryColor"
    case tabbarBackground = "tabbarBackground"
    case tabbarSelected = "tabbarSelected"
    case tabbarUnselected = "tabbarUnselected"
    case tabbarSlider = "tabbarSlider"
    
    func getUIColor(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(named: self.rawValue)?.withAlphaComponent(alpha) ?? .clear
    }
}

extension UIColor {
    convenience init(hex: String, alpha: Double = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        
        switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
                
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
                
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
                
            default:
                (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: (CGFloat(a) / 255) * CGFloat(alpha))
    }
    
}
