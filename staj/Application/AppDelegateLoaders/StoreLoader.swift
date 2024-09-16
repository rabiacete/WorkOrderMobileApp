// 
//  StoreLoader.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import UIKit

public struct StoreLoader: AppLoadable {
    
    fileprivate let isTestMode = false
    
    public func configure(_ application: UIApplication, _ launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        #if TESTMODE
        if isTestMode {
            return
        }
        #endif
        
        StoreManager.setup {
            
        }
    }

    
}
