//
//  LoginViewModel.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 16.09.2024.
//

import Foundation

protocol LoginViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == LoginViewModel.LoginAction {
}

class LoginViewModel: BaseViewModel, ActionSendable {
    
    enum LoginAction {
        case presentationModel(PresentationModel)
        case openRegisterPage
        case userLoginWithSuccess
        case userCannotLogined
    }
    
    struct PresentationModel {
        
    }
    
    var observer: Callback<LoginAction>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func registerButtonTapped() {
        sendAction(.openRegisterPage)
    }
    
    func loginButtonTapped(email: String, password: String) {
        
        AuthManager.shared.login(email: email, password: password) { [weak self] response in
            guard let self else { return }
            
            if response {
                self.sendAction(.userLoginWithSuccess)
            } else {
                self.sendAction(.userCannotLogined)
            }
        }
    }
}
