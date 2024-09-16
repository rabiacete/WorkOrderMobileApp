//
//  RegisterViewModel.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation

protocol RegisterViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == RegisterViewModel.RegisterAction {

}

class RegisterViewModel: BaseViewModel, ActionSendable {
    
    enum RegisterAction {
        case presentationModel(PresentationModel)
        case backTapped
    }
    
    struct PresentationModel {
        
    }
    
    var observer: Callback<RegisterAction>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func backButtonTapped() {
        sendAction(.backTapped)
    }
    
    func registerButtonTapped(email: String, password: String, passwordConfirm: String) {
        
    }
}
