//
//  FirestoreManager.swift
//  staj
//
//  Created by Rabia on 10.09.2024.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    
    public static let shared = FirestoreManager()
    private let firestore = Firestore.firestore()
    private init() {}
    
    func addDocument(collection: FirestoreModels, data: [String: Any], completion: @escaping Callback<Bool>) {
    firestore.collection(collection.collectionName).addDocument(data: data) { error in
            if let error = error {
                completion(false)
                return
            }
            completion(true)
        }
    }
        
    func updateDocument(collection: FirestoreModels, documentId: String, data: [String: Any], completion: @escaping Callback<Bool>) {
        
        firestore.collection(collection.collectionName).document(documentId).updateData(data)  { error in
            
            if let error = error {
               
                completion(false)
                return
            }
            completion(true)
        }
    }

    func deleteDocument(collection: FirestoreModels, documentId: String, completion: @escaping Callback<Bool>) {
        firestore.collection(collection.collectionName).document(documentId).delete  { error in
            
            if let error = error {
               
                completion(false)
                return
            }
            completion(true)
        }
        
        
    }
    func getDocuments<T: Codable>(collection: FirestoreModels, model: T.Type, completion: @escaping Callback<[T]?>) {
        
        firestore.collection(collection.collectionName).getDocuments { snapshot, error in
            if let error = error  {
                completion(nil)
                return
            }
            var response: [T] = []
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data())
                        let data = try JSONDecoder().decode(T.self, from: jsonData)
                        response.append(data)
                    } catch {
                        
                    }
                }
            }
        completion(response)
        }
    }
}


enum FirestoreModels {
    
    case teams
    case items
    case states
    case workflow
    
    
    var collectionName : String {
        
        switch self {
        case .teams:
            return "Teams"
        case .items:
            return "Items"
        case .states:
            return  "States"
        case .workflow:
            return  "Workflow"
        }
        
        
    }
    
    
    
}

struct TeamModel : Codable {
    
    var teamName : String
    var teamCode : Int
    
}

struct ItemModel : Codable {
    
    var itemName : String
    var itemCode : Int
}

struct StateModel : Codable {
    
    var stateName : String
    var stateCode : Int
}

struct WorkflowModel : Codable {
    
    var workflowName : String
    var workflowCode : Int
    
}

extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any] {
                return jsonObject
            }
        } catch {
            print("Error converting struct to dictionary: \(error.localizedDescription)")
        }
        return nil
    }
}
