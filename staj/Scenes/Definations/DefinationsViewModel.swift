//
//  DefinationsViewModel.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation

protocol DefinationsViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == DefinationsViewModel.DefinationsAction {

}

class DefinationsViewModel: BaseViewModel, ActionSendable {
    
    enum DefinationsAction {
        case presentationModel(PresentationModel)
    }
    
    struct PresentationModel {
        
    }
    
    var observer: Callback<DefinationsAction>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
