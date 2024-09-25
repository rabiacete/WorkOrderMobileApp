//
//  AuthManager.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    public static let shared = AuthManager()
    private let auth = Auth.auth()
    
    private init() {
        
    }
    
    public func signOut(completion: @escaping CallbackVoid) {
        try? auth.signOut()
        completion()
    }
    
    public func isUserLogined() -> Bool {
        if let user = auth.currentUser {
            return true
        }
        
        return false
    }
    
    public func login(email: String, password: String, completion: @escaping Callback<Bool>) {
        if isUserLogined() {
            completion(false)
            return
        }
        
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false)
                return
            }
            
            guard let result else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
    public func register(email: String, password: String, completion: @escaping Callback<Bool>) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false)
                return
            }
            
            guard let result else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
}
