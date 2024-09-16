// 
//  LocalizationManager.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

public protocol Localizationable {
    var currentLanguageType: LanguageType? { get set }
    
    func setLanguage(_ type: LanguageType)
    func loadLocalLocalizations()
    
}

public protocol Localizer {
    func getLocalizedText(key: String) -> String
    func getLocalizedText(key: String, texts: Any...) -> String
}

final public class LocalizationManager: Localizationable, Localizer {
    let localizationStorage: LocalizationStoraged
    
    public init(localizationStorage: LocalizationStoraged = LocalizationStoraged.shared) {
        self.localizationStorage = localizationStorage
    }
    
    public var currentLanguageType: LanguageType?
    
    public func setLanguage(_ type: LanguageType) {
        currentLanguageType = type
    }
    
    public func loadLocalLocalizations() {
        guard let path = Bundle.main.path(forResource: currentLanguageType?.fileName, ofType: "plist") else { return }
        
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        guard let plist = try! PropertyListSerialization.propertyList(from: data,
                                                                     options: .mutableContainers,
                                                                     format: nil) as? [String:String] else { return }
        localizationStorage.localResources = plist
    }
    
    public func getLocalizedText(key: String) -> String {
        guard let value = localizationStorage.localResources[key] else {
            return key
        }
        
        return value
    }
    
    public func getLocalizedText(key: String, texts: Any...) -> String {
        let parameterStrings = texts.compactMap({ String(describing: $0) })
        return localizedStringWithExternalText(forKey: key, texts: parameterStrings)
    }
    
    private func localizedStringWithExternalText(forKey: String, texts: [String]) -> String {
        var locString = getLocalizedText(key: forKey)
        for (index, text) in texts.enumerated() {
            locString = locString.replacingOccurrences(of: "{p\(index)}", with: text)
        }
        return locString
    }
}

final public class LocalizationStoraged {
    public static let shared: LocalizationStoraged = LocalizationStoraged()
    
    var localResources: [String:String] = [:]
}


public enum LanguageType: String, Codable, CustomStringConvertible, CaseIterable {
    case tr
    case en
    
    public var description: String {
        switch self {
        case .tr:
            return "tr-TR"
        case .en:
            return "en-GB"
        }
    }
    
    public var fileName: String {
        switch self {
        case .tr:
            return "Localization-Tr"
        case .en:
            return "Localization-En"
        }
    }
    
    public var displayName: String {
        switch self {
        case .tr:
            return "Türkçe (TR)"
        case .en:
            return "English (EN)"
        }
    }
}
