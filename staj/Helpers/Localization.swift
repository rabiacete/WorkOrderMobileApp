// 
//  Localization.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

final class Localization {
    static public let shared: Localization = Localization()
    
    var localizer = LocalizationManager()
    
    private init() {
        localizer.setLanguage(.en)
        localizer.loadLocalLocalizations()
    }
}

public protocol LocalizableEnum {
    func getLocalizedValue(key: String) -> String
}

enum AppStrings: String {
    case appName = "APP_NAME"
    case restoreFailed = "SM_RESTORE_FAILED"
    case restoreSuccess = "SM_RESTORE_SUCCESS"
    case notingToRestore = "SM_NOTING TO RESTORE"
    case purchaseSuccess = "SM_PURCHASE_SUCCESS"
    case recipientValidationFailed = "SM_RECIPIENT_VALIDATION_FAILED"
    case unknowError = "SM_UNKNOW"
    case clientInvalid = "SM_CLIENT_INVALID"
    case paymentCancelled = "SM_PAYMENT_CANCELLED"
    case paymentInvalid = "SM_PAYMENT_INVALID"
    case paymentNotAllowed = "SM_PAYMENT_NOT_ALLOWED"
    case productNotAvailable = "SM_PRODUCT_NOT_AVAILABLE"
    case permissionDenied = "SM_PERMISSION_DENIED"
    case networkFailed = "SM_NETWORK_FAIL"
    case revoked = "SM_REVOKED"
    case skip = "skip"
        case next = "next"
        case continueText = "continueText"
        case startToUse = "startToUse"
        case onboardingTitlePageOne = "onboardingTitlePageOne"
        case onboardingDescriptionPageOne = "onboardingDescriptionPageOne"
        case onboardingTitlePageTwo = "onboardingTitlePageTwo"
        case onboardingDescriptionPageTwo = "onboardingDescriptionPageTwo"
        case onboardingTitlePageThree = "onboardingTitlePageThree"
        case onboardingDescriptionPageThree = "onboardingDescriptionPageThree"
    var localizedString: String {
        return getLocalizedValue(key: self.rawValue)
    }
}

extension AppStrings: LocalizableEnum {
    func getLocalizedValue(key: String) -> String {
        return Localization.shared.localizer.getLocalizedText(key: key)
    }
}
