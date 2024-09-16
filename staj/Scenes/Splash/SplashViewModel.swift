// 
//  SplashViewModel.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

protocol SplashViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == SplashViewModel.SplashhAction {
  
}


class SplashViewModel: BaseViewModel, SplashViewModelProtocol, ActionSendable {
    
    enum SplashhAction {
        case presentationModel(PresentationModel)
        case openOnboarding
    }
    
    struct PresentationModel {
        let appName: AppStrings
        let logo: Images
    }
    
    var observer: Callback<SplashhAction>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendAction(.presentationModel(.init(appName: .appName, logo: .star)))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            guard let self else { return }
            self.sendAction(.openOnboarding)
        })
    }
}
