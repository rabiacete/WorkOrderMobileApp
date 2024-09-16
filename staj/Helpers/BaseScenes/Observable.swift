// 
//  Observable.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

class Observable<T> {
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T? {
        didSet {
            listener?(value!)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    init() {}
}

public protocol ActionSendable {
    associatedtype ActionType
    var observer: Callback<ActionType>! { get set }
    func sendAction(_ action: ActionType)
}

public extension ActionSendable {
    func sendAction(_ action: ActionType) {
        Task {
            async let _ = await MainActor.run {
                observer?(action)
            }
        }
    }
}

public protocol ObserveManageable {
    associatedtype ActionType
    var observer: Callback<ActionType>! { get set }
}


