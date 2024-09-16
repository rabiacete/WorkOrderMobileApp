// 
//  Constants.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

class Constants {
    public static var privacyPolicyUrl = ""
    public static var termsAndConditionUrl = ""
    public static var supportMailAddress = ""
    public static var appId = ""
    public static var appSecretSharedKey = ""
    public static var bundleId = ""
    
    public static var paywallCloseButtonDelayAsSecond = 0
    public static var paywallShouldBeForceWhenAppOpened = false
}

enum ConsumableProduct: String, CaseIterable {
    case productOne = "product1"
    case productTwo = "product2"
    case productThree = "product3"
    
    static var allCases: [ConsumableProduct] {
        return []
    }
    
    var identifier: String {
        return Constants.bundleId + "." + self.rawValue
    }
}

enum AutoSubscription: String, CaseIterable {
    case oneWeek = "oneWeek"
    case twoWeek = "twoWeek"
    case oneMonth = "oneMonth"
    case threeMonth = "threeMonth"
    case sixMonth = "sixMonth"
    case oneYear = "oneYear"
    
    static var allCases: [AutoSubscription] {
        return [.oneWeek]
    }
    
    var identifier: String {
        return Constants.bundleId + "." + self.rawValue
    }
}
