// 
//  NotificationManager.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

public protocol NotificationManagerProtocol {
    func setFcmToken(_ with: String)
    func getFcmToken() -> String
}

public class NotificationManager: NotificationManagerProtocol {
    
    private let userDefaults: UserDefaultsHelperable

    public init(_ userDefaults: UserDefaultsHelperable = UserDefaultsHelper()) {
        self.userDefaults = userDefaults
    }
    
    public func setFcmToken(_ with: String) {
        self.userDefaults.save(key: .general(generalKey: .fcmToken), data: with)
    }
    
    public func getFcmToken() -> String {
        if let token: String = userDefaults.get(key: .general(generalKey: .fcmToken)) {
            return token
        }
        return ""
    }
}
