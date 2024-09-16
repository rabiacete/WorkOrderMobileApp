// 
//  AppDelegate.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Variables

    static let shared = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    
    private lazy var loadableProvider: AppLoadable = {
        return AppConfigurator()
    }()

    // MARK: - Lifecycle

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        loadableProvider.configure(application, launchOptions)
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        loadableProvider.configureDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        loadableProvider.configureWillEnterForeground(application)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        loadableProvider.configureDidBecomeActive(application)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        loadableProvider.configure(application, deviceToken)
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        loadableProvider.configure(application, continue: userActivity, restorationHandler: restorationHandler)
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completitonHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completitonHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didRecive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
