// 
//  EventsProvider.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import FirebaseAnalytics

public protocol EventsProvidable {
    func send(_ name: String, parameters: [String: Any]?, providerTypes: [EventsProviderType])
}

public enum EventsProviderType {
    case firebase
}

protocol EventsProviderProtocol {
    func sendEvent(name: String, parameters: [String: Any]?)
}

extension EventsProvidable {
    func send(_ name: String, parameters: [String: Any]?) {
        send(name, parameters: parameters, providerTypes: [.firebase])
    }
    
    func send(_ name: String) {
        send(name, parameters: nil, providerTypes: [.firebase])
    }
}

final public class EventsProvider: EventsProvidable {
    static public let shared: EventsProvidable = EventsProvider()
    
    private lazy var firebaseEventProvider = FirebaseEventsProvider()
    
    private func provider(_ type: EventsProviderType) -> EventsProviderProtocol {
        switch type {
        case .firebase:
            return firebaseEventProvider
        }
    }
    
    public func send(_ name: String, parameters: [String: Any]?, providerTypes: [EventsProviderType] = [.firebase]) {
        for type in providerTypes {
            provider(type).sendEvent(name: name, parameters: parameters)
        }
    }
}

final class FirebaseEventsProvider: EventsProviderProtocol {
    func sendEvent(name: String, parameters: [String: Any]? = nil) {
        
    }
}
