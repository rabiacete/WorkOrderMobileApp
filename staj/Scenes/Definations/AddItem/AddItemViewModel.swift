//
//  AddItemViewModel.swift
//  staj
//
//  Created by Rabia on 19.09.2024.
//

import Foundation

protocol AddItemViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == AddItemViewModel.AddItemAction {

}

class AddItemViewModel: BaseViewModel {
    
    enum AddItemAction {
        case presentationModel(PresentationModel)
    }
    
    struct PresentationModel {
        
    }
    
    var observer: Callback<AddItemAction>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
