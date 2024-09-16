// 
//  Fonts.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

enum Fonts {
    enum SFProText: String {
        case regular = "SFProText-Regular"
        case medium = "SFProText-Medium"
        case bold = "SFProText-Bold"
        
        func getAsFont(with size: CGFloat = 14) -> UIFont {
            return UIFont(name: self.rawValue, size: size) ?? UIFont()
        }
    }
}
