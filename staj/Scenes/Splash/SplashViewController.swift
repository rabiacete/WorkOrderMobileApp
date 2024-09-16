// 
//  SplashViewController.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

class SplashViewController: BaseViewController<SplashViewModel,SplashView> {
    
    override func viewDidLoad() {
        bindViewModel()
        super.viewDidLoad()
        bindViewCallback()
    }
    
    private func bindViewModel() {
        viewModel.observer = { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .presentationModel(let model):
                self.viewContainer.setPresentationModel(model: model)
            case .openOnboarding:
                self.openOnboarding()
            case .openLogin:
                self.openLogin()
            case .openApp:
                self.openApp()
            }
        }
    }
    
    private func bindViewCallback() {
        
    }
    
    func openOnboarding() {
        presentScene(scene: .onboarding, animated: true)
    }
    
    func openLogin() {
        presentScene(scene: .login, animated: true)
    }
    
    func openApp() {
        presentScene(scene: .tabbar, animated: true)
    }
}



