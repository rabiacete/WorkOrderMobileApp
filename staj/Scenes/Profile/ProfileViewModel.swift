//
//  ProfileViewModel.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation

protocol ProfileViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == ProfileViewModel.ProfileAction {

}

class ProfileViewModel: BaseViewModel, ActionSendable {
    
    enum ProfileAction {
        case presentationModel(PresentationModel)
    }
    
    struct PresentationModel {
        
    }
    
    var observer: Callback<ProfileAction>!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
