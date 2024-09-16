// 
//  StoreManager.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import StoreKit
import SVProgressHUD
import SwiftyStoreKit

class StoreManager {
    
    static var inAppProducts: Array<SKProduct>?
    
    static let consumableProductIds = ConsumableProduct.allCases.map({ return $0.identifier})
    
    static var subscriptionProducts = AutoSubscription.allCases.map({ return $0.identifier})
    
    private static func setUserSubscriptionStatus(state: Bool) {
        UserDefaultsHelper().save(key: .general(generalKey: .isUserPremium), data: state)
    }
    
    static func setup(completion: @escaping () -> ()) {
        
        setUserSubscriptionStatus(state: false)
        
        getProducts()
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                @unknown default:
                    break
                }
            }
        }
        
        receiptValidation { (_) in
            completion()
        }
    }
    
    class func getProducts() {
        
        var allProductIds = [String]()
        allProductIds.append(contentsOf: subscriptionProducts)
        allProductIds.append(contentsOf: consumableProductIds)
        
        SwiftyStoreKit.retrieveProductsInfo(Set<String>(allProductIds)) { result in
            
            guard result.error == nil else {
                print("Error: \(result.error ?? "" as! Error)")
                return
            }
            
            if !result.retrievedProducts.isEmpty {
                inAppProducts = Array(result.retrievedProducts)
                
                for product in result.retrievedProducts {
                    print("Product: \(product.localizedTitle), Price: \(product.localizedPrice ?? ""), Description: \(product.localizedDescription)")
                }
            }
            
            for invalidProductID in result.invalidProductIDs {
                print("Invalid product identifier: \(invalidProductID)")
            }
        }
    }
    
    class func restoreSubscription(completion: @escaping (Bool,AppStrings) -> Void) {
        SwiftyStoreKit.restorePurchases(atomically: true) { result in
            if result.restoreFailedPurchases.count > 0 {
                completion(false, .restoreFailed)
            } else if result.restoredPurchases.count > 0 {
                receiptValidation(completion: { result in
                    completion(result, result ? .restoreSuccess : .notingToRestore)
                })
            } else {
                completion(false, .notingToRestore)
            }
        }
    }
    
    class func purchase(
        productID: String,
        completion: @escaping (_ purchaseIsSucceed: Bool, _ message: AppStrings)  -> Void
    ) {
        SwiftyStoreKit.purchaseProduct(productID, quantity: 1, atomically: true) { result in
            switch result {
            case .success(let purchase):
                
                print("PURCHASE: \(purchase.originalTransaction?.transactionIdentifier ?? "")")
                
                
                receiptValidation { (success) in
                    
                    
                    completion(success, success ? .purchaseSuccess : .recipientValidationFailed)
                }
                
            case .error(let error):
                
                var errorMessage:AppStrings = .unknowError
                
                switch error.code {
                case .unknown: errorMessage = .unknowError
                case .clientInvalid: errorMessage = .clientInvalid
                case .paymentCancelled: errorMessage = .paymentCancelled
                case .paymentInvalid: errorMessage = .paymentInvalid
                case .paymentNotAllowed: errorMessage = .paymentNotAllowed
                case .storeProductNotAvailable: errorMessage = .productNotAvailable
                case .cloudServicePermissionDenied: errorMessage = .permissionDenied
                case .cloudServiceNetworkConnectionFailed: errorMessage = .networkFailed
                case .cloudServiceRevoked: errorMessage = .revoked
                default: errorMessage = .unknowError
                }
                
                completion(false, errorMessage)
            }
        }
    }
    
    class func receiptValidation(
        completion: @escaping (_ success: Bool)  -> Void
    ) {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: Constants.appSecretSharedKey)
        
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                
                var isSubscribed = false
                
                // Verify the subscriptions
                let subscriptionResult = SwiftyStoreKit.verifySubscriptions(ofType: .autoRenewable, productIds: Set(subscriptionProducts), inReceipt: receipt)
                
                switch subscriptionResult {
                case .purchased(let expiryDate, let items):
                    let date = Date()
                    for item in items {
                        if (item.subscriptionExpirationDate ?? date) > date {
                            
                            
                            
                        }
                    }
                    isSubscribed = true
                    print("Product is valid until \(expiryDate)\n")
                    
                case .notPurchased:
                    print("Product is not Purchased")
                    
                case .expired(let expiryDate, _):
                    print("Product is expired since \(expiryDate)\n")
                }
                
                
                consumableProductIds.forEach { (productId) in
                    // Verify the Purchase
                    let purchaseResult = SwiftyStoreKit.verifyPurchase(productId: productId, inReceipt: receipt)
                    
                    switch purchaseResult {
                    case .purchased(item: let item):
                        //isPurchased = true
                        print("Product details: \(item)\n")
                    case .notPurchased:
                        print("Product details: Not Purchased")
                    }
                }
                
                setUserSubscriptionStatus(state: isSubscribed)
                
                completion(isSubscribed)
                
            case .error(let error):
                print("Receipt verification failed: \(error)")
                completion(false)
            }
        }
    }
}

extension StoreManager {
    
    static func getPrice(productId: String, isSymbolLocationEnd: Bool = true) -> String {
        var price = ""
        var currencyCode = ""
        if let products = inAppProducts {
            
            for product in products {
                if product.productIdentifier == productId {
                    currencyCode = product.priceLocale.currencySymbol ?? "$"
                    price = String((product.price.doubleValue))
                }
            }
            
        }
        
        return isSymbolLocationEnd ? (price + currencyCode) : (currencyCode + price)
    }
    
    static func getPriceAsDouble(productId: String) -> Double {
        var price = 0.0
        if let products = inAppProducts {
            
            for product in products {
                if product.productIdentifier == productId {
                    price = product.price.doubleValue
                }
            }
            
        }
        
        return price
    }
    
    static func getComparedPercentage(baseProduct: String, baseProductDurationAsWeek: Double, comparedProduct: String, comparedProductDurationAsWeek: Double) -> String {
        
        let baseProductPrice = getPriceAsDouble(productId: baseProduct) / baseProductDurationAsWeek
        let comparedProductPrice = getPriceAsDouble(productId: comparedProduct) / comparedProductDurationAsWeek
        
        let compare = comparedProductPrice * 100.0 / baseProductPrice
        let discountPercentage = Int(100.0 - compare)
        
        return String(discountPercentage)
    }
}
