// 
//  OnboardingViewController.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

class OnboardingViewController: BaseViewController<OnboardingViewModel,OnboardingView> {
    
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
            case .currentPageModel(let model):
                self.viewContainer.setCurrentPageModel(model: model)
            case .openTabbar:
                self.openTabbar()
            case .openLogin:
                self.openLogin()
            }
        }
    }
    
    private func bindViewCallback() {
        viewContainer.setSkipButtonAction { [weak self] in
            guard let self else { return }
            self.viewModel.skipButtonPressed()
        }
        
        viewContainer.setContinueButtonAction { [weak self] in
            guard let self else { return }
            self.viewModel.nextButtonPressed()
        }
    }
    
    private func openTabbar() {
        presentScene(scene: .tabbar, animated: true)
    }
    
    private func openLogin() {
        presentScene(scene: .login, animated: true)
    }
}

