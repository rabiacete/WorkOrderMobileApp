// 
//  NetworkManager.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    public static let sharedInstance = NetworkManager()
    
    private init() {
        
    }
    
    let header = ["Content-Type": "application/json",
                  "Accept": "application/json"] as HTTPHeaders
    
    public func createRequest<T: Codable>(for endpoint: EndPoint, params: [String: Any] = [:], response: T.Type, completion: @escaping(T?) -> ()) {
        let request = AF.request(endpoint.rawValue,
                                 method: endpoint.method,
                                 parameters: params,
                                 encoding: URLEncoding.default, headers: header)
        
        Logger.sharedInstance.log("Network request created.", state: .success)
        Logger.sharedInstance.log("---> HTTP Method: " + endpoint.method.rawValue)
        Logger.sharedInstance.log("---> Endpoint: " + endpoint.name)
        request.responseDecodable(of: T.self) { response in
            Logger.sharedInstance.log("Request sent.")
            guard let data = response.value else {
                Logger.sharedInstance.log("Request failed. Error: " + (response.error?.localizedDescription ?? "nil"), state: .error)
                completion(nil)
                return
            }
            Logger.sharedInstance.log("Request done.", state: .success)
            completion(data)
        }
    }
    
}



