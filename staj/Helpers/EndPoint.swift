// 
//  EndPoint.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import Alamofire

enum EndPoint: String {
    case base = ""
    
    var method: Alamofire.HTTPMethod {
        switch self {
            case .base: return .get
        }
    }
    
    var name: String {
        switch self {
            case .base: return ""
        }
    }
}
