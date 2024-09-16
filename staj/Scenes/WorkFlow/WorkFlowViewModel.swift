//
//  WorkFlowViewModel.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation

protocol WorkFlowViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == WorkFlowViewModel.WorkFlowAction {

}

class WorkFlowViewModel: BaseViewModel, ActionSendable {
    
    enum WorkFlowAction {
        case presentationModel(PresentationModel)
    }
    
    struct PresentationModel {
        
    }
    
    var observer: Callback<WorkFlowAction>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
