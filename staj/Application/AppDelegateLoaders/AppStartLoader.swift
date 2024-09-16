// 
//  AppStartLoader.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import Firebase
import UIKit

public struct AppStartLoader: AppLoadable {
    
    // MARK: - Variables
    
    private let notificationManager: NotificationManagerProtocol = NotificationManager()
    
    public func configure(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        WindowContainer.window = (UIApplication.shared.delegate as? AppDelegate)?.window ?? UIWindow(frame: UIScreen.main.bounds)
        
        WindowContainer.window?.rootViewController = SplashViewController()
        WindowContainer.window?.makeKeyAndVisible()
    }

    
}
