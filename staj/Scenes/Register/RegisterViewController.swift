//
//  RegisterViewController.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation

class RegisterViewController: BaseViewController<RegisterViewModel, RegisterView> {
    
    // MARK: - Lifecycle
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
            case .backTapped:
                self.dismiss(animated: true)
            }
        }
    }
    
    private func bindViewCallback() {
        viewContainer.setButtonCallback { [weak self] state in
            guard let self else { return }
            switch state {
            case .back:
                self.viewModel.backButtonTapped()
            case .register(let email, let password, let passwordConfirm):
                self.viewModel.registerButtonTapped(email: email, password: password, passwordConfirm: passwordConfirm)
            }
        }
    }
}
