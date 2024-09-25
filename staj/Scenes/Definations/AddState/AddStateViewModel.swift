//
//  AddStateViewModel.swift
//  staj
//
//  Created by Rabia on 19.09.2024.
//

import Foundation

protocol AddStateViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == AddStateViewModel.AddStateAction {

}

class AddStateViewModel: BaseViewModel {
    
    enum AddStateAction {
        case presentationModel(PresentationModel)
    }
    
    struct PresentationModel {
        
    }
    
    var observer: Callback<AddStateAction>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
