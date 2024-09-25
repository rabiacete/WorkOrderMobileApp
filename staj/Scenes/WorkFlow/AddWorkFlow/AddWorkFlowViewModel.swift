//
//  AddWorkFlowViewModel.swift
//  staj
//
//  Created by Rabia on 19.09.2024.
//

import Foundation
import Firebase
import Combine

protocol AddWorkFlowViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == AddWorkFlowViewModel{
}
    //.AddWorkFlowAction {

//}

class AddWorkFlowViewModel: BaseViewModel {
  
    enum AddTeamAction {
        case presentationModel(PresentationModel)
        case backTapped

    }
  
 
    struct PresentationModel {
        
    }
    
    var observer: Callback<AddTeamAction>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    
    /*
    struct WorkOrder {
        let id: String
        let name: String
        let code: String
    }
    
    let db = Firestore.firestore()
    
    
    enum AddWorkFlowAction {
        case presentationModel(PresentationModel)
        case backTapped
    }
    
    struct PresentationModel {
        let workName: String
        let workCode: String
    }
    
    func addWorkOrder(name: String, code: String) {
        let newWorkOrder = WorkOrder(id: UUID().uuidString, name: name, code: code)
        db.collection("workOrders").addDocument(data: [
            "id": newWorkOrder.id,
            "name": newWorkOrder.name,
            "code": newWorkOrder.code
        ]) { error in
            if let error = error {
                print("Error adding work order: \(error.localizedDescription)")
            } else {
                print("Work order added successfully!")
                self.observer?(.presentationModel(PresentationModel(workName: name, workCode: code)))
            }
        }
    }
    var observer: Callback<AddWorkFlowAction>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        */
    }
    
}
