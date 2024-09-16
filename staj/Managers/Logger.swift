// 
//  Logger.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
class Logger {
    public static let sharedInstance = Logger()
    
    private init() {
        
    }
    
    public func log(_ message: String, state: LogState = .default) {
        print(state.rawValue + message)
    }
    
}

enum LogState: String {
    case error = "Logger Error: "
    case success = "Logger Success: "
    case warning = "Logger Warning: "
    case `default` = "Logger: "
}
