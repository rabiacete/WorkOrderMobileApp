// 
//  UserDefaults.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

public protocol UserDefaultsHelperable {
    func saveSharedData<T: Codable>(key: UserDefaultsHelper.Keys, data: T)
    func getSharedData<T: Codable>(key: UserDefaultsHelper.Keys) -> T?
    
    func save<T: Codable>(key: UserDefaultsHelper.Keys, data: T)
    func get<T: Codable>(key: UserDefaultsHelper.Keys) -> T?
    
    func delete(key: UserDefaultsHelper.Keys)
    func deleteAllData()
}

public extension UserDefaultsHelperable {
    func saveSharedData<T: Codable>(key: UserDefaultsHelper.Keys, data: T) {
        UserDefaultsHelper.saveSharedData(key: key, data: data)
    }
    
    func getSharedData<T: Codable>(key: UserDefaultsHelper.Keys) -> T? {
        return UserDefaultsHelper.getSharedData(key: key)
    }
    
    func save<T: Codable>(key: UserDefaultsHelper.Keys, data: T) {
        UserDefaultsHelper.saveData(key: key, data: data)
    }
    
    func get<T: Codable>(key: UserDefaultsHelper.Keys) -> T? {
        return UserDefaultsHelper.getData(key: key)
    }
    
    func delete(key: UserDefaultsHelper.Keys) {
        return UserDefaultsHelper.deleteData(key: key)
    }
    
    func deleteAllData() {
        UserDefaultsHelper.deleteAllData()
    }
}

public class UserDefaultsHelper: UserDefaultsHelperable {
    private static let defaults = UserDefaults.standard
    private static let sharedDefaults = UserDefaults(suiteName: "")
    
    public init() {}
    
    public enum Keys {
        
        case general(generalKey: GeneralKey)
        case chat(chatKey: ChatKey)
        
        var value: String {
            switch self {
            case .general(let generalKey):
                return generalKey.value
            case .chat(let chatKey):
                return chatKey.value
            }
        }
    }
    
    public enum GeneralKey: String {
        
        case firstLaunch
        case fcmToken
        case isUserPremium
        
        var value: String {
            switch self {
            default:
                return self.rawValue
            }
        }
    }
    
    public enum ChatKey: String {
        
        case chatList
        
        var value: String {
            switch self {
            default:
                return self.rawValue
            }
        }
    }
}

extension UserDefaultsHelper {
    static func saveSharedData<T: Codable>(key: Keys, data: T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            sharedDefaults?.set(encoded, forKey: key.value)
        }
    }
    
    static func getSharedData<T: Codable>(key: Keys) -> T? {
        if let data = sharedDefaults?.object(forKey: key.value) as? Data {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(T.self, from: data) {
                return object
            }
        }
        return nil
    }
    
    static func saveData<T: Codable>(key: Keys, data: T) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            defaults.set(encoded, forKey: key.value)
        }
    }
    
    static func getData<T: Codable>(key: Keys) -> T? {
        if let data = defaults.object(forKey: key.value) as? Data {
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(T.self, from: data) {
                return object
            }
        }
        return nil
    }
    
    static func deleteData(key: Keys) {
        defaults.removeObject(forKey: key.value)
    }
    
    static func deleteDatas(keys: [Keys]) {
        for key in keys {
            defaults.removeObject(forKey: key.value)
        }
    }
    
    static func deleteAllData() {
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    static func saveDataObject<T>(key: Keys, object: T) where T: Codable {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            defaults.set(encoded, forKey: key.value)
        }
    }
}
