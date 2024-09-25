//
//  LoginViewController.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 16.09.2024.
//

import Foundation
class LoginViewController: BaseViewController<LoginViewModel, LoginView> {
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
            case .openRegisterPage:
              self.presentScene(scene: .register, animated: true)
            case .userLoginWithSuccess:
                self.presentScene(scene: .tabbar, animated: true)
            case .userCannotLogined:
                self.viewContainer.showLoginError()
            }
        }}
    private func bindViewCallback() {
        viewContainer.setButtonCallback { [weak self] state in
            guard let self else { return }
            switch state {
            case .register:
            self.viewModel.registerButtonTapped()
            case .login(let email, let password):
                self.viewModel.loginButtonTapped(email: email, password: password)
            }
        }}}
