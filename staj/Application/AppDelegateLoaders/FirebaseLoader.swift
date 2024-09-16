// 
//  FirebaseLoader.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import Firebase
import FirebaseCrashlytics
import UIKit
import NotificationCenter
import FirebaseRemoteConfig
import FirebaseMessaging
import SVProgressHUD

final class FirebaseLoader: NSObject, AppLoadable {
    
    // MARK: - Variables
    
    private let notificationManager: NotificationManagerProtocol = NotificationManager()
    
    var remoteConfig: RemoteConfig!
    
    public override init() { 
        FirebaseApp.configure()
        remoteConfig = RemoteConfig.remoteConfig()
                let settings = RemoteConfigSettings()
                settings.minimumFetchInterval = 0
                remoteConfig.configSettings = settings
                SVProgressHUD.show()
    }
    
    // MARK: - Lifecycle
    
    public func configure(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        configureFirebase()
        registerPush()
        fetchRemoteConfig(launchOptions: launchOptions)
    }
    
    private func registerPush() {
        UNUserNotificationCenter.current().delegate = AppDelegate.shared
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    private func configureFirebase() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        Messaging.messaging().delegate = self
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
    }
    
    private func fetchRemoteConfig(launchOptions:[UIApplication.LaunchOptionsKey: Any]?) {
        let expirationDuration = 0
        remoteConfig.fetch(withExpirationDuration: TimeInterval(expirationDuration)) { (status, error) -> Void in
            
            if status == .success {
                print("Config fetched!")
                RemoteConfig.remoteConfig().activate { (result, error) in
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                    }
                    
                    DispatchQueue.main.async {
                        Constants.privacyPolicyUrl = self.remoteConfig["privacyPolicyUrl"].stringValue ?? Constants.privacyPolicyUrl
                        Constants.termsAndConditionUrl = self.remoteConfig["termsAndConditionUrl"].stringValue ?? Constants.termsAndConditionUrl
                        Constants.supportMailAddress = self.remoteConfig["supportMailAddress"].stringValue ?? Constants.supportMailAddress
                        Constants.appSecretSharedKey = self.remoteConfig["appSecretSharedKey"].stringValue ?? Constants.appSecretSharedKey
                        
                        Constants.paywallCloseButtonDelayAsSecond = self.remoteConfig["paywallCloseButtonDelayAsSecond"].numberValue.intValue
                        Constants.paywallShouldBeForceWhenAppOpened = self.remoteConfig["paywallShouldBeForceWhenAppOpened"].boolValue
                    }
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            
            
        }
    }
    
}

extension FirebaseLoader: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistirationToken fcmToken: String?) {
        guard let fcmToken else { return }
        notificationManager.setFcmToken(fcmToken)
    }
}
