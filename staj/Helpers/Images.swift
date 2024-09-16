// 
//  Images.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

enum Images: String {
    case star = "star"
    case back = "back"
    case tab1 = "tab1"
    case tab2 = "tab2"
    case tab3 = "tab3"

    func getUIImage(with tintColor: Colors) -> UIImage {
        return (UIImage(named: self.rawValue)?.withTintColor(tintColor.getUIColor()))~
    }
    
    func getUIImage() -> UIImage {
        return UIImage(named: self.rawValue)~
    }
}
