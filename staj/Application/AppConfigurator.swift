// 
//  AppConfigurator.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

class AppConfigurator: AppLoadable {

    // MARK: - Variables
    
    public lazy var loadables: [AppLoadable] = {
        return [FirebaseLoader(),
                AppStartLoader(),
                StoreLoader()]
    }()

    // MARK: - Lifecycle

    func configure(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        loadables.forEach { $0.configure(application, launchOptions) }
    }
    
    func configure(_ app: UIApplication, open url: URL, options: [UIApplication.LaunchOptionsKey: Any]) {
        loadables.forEach { $0.configure(app, open: url, options: options) }
    }
    
    func configure(_ application: UIApplication, _ deviceToken: Data) {
        loadables.forEach { $0.configure(application, deviceToken) }
    }
    
    func configure(_ application: UIApplication,
                   continue userActivity: NSUserActivity,
                   restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) {
        loadables.forEach { $0.configure(application, continue: userActivity, restorationHandler: restorationHandler) }
    }
    
    func configureDidEnterBackground(_ application: UIApplication) {
        loadables.forEach { $0.configureDidEnterBackground(application) }
    }
    
    func configureWillEnterForeground(_ application: UIApplication) {
        loadables.forEach { $0.configureWillEnterForeground(application) }
    }
    
    func configureDidBecomeActive(_ application: UIApplication) {
        loadables.forEach { $0.configureDidBecomeActive(application) }
    }
    
}

protocol AppLoadable {
    func configure(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    func configure(_ app: UIApplication, open url: URL, options: [UIApplication.LaunchOptionsKey: Any])
    func configure(_ application: UIApplication, _ deviceToken: Data)
    func configure(_ application: UIApplication,
                   continue userActivity: NSUserActivity,
                   restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void)
    func configureDidEnterBackground(_ application: UIApplication)
    func configureWillEnterForeground(_ application: UIApplication)
    func configureDidBecomeActive(_ application: UIApplication)
}

extension AppLoadable {
    func configure(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) { }
    func configure(_ app: UIApplication, open url: URL, options: [UIApplication.LaunchOptionsKey: Any]) { }
    func configure(_ application: UIApplication, _ deviceToken: Data) { }
    func configure(_ application: UIApplication,
                   continue userActivity: NSUserActivity,
                   restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) { }
    func configureDidEnterBackground(_ application: UIApplication) { }
    func configureWillEnterForeground(_ application: UIApplication) { }
    func configureDidBecomeActive(_ application: UIApplication) { }
}
