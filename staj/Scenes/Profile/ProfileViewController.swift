//
//  ProfileViewController.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation
class ProfileViewController: BaseViewController<ProfileViewModel, ProfileView> {
    
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
            }
        }
    }
    private func bindViewCallback() {
        // Logout butonu callback'ini ayarla
        viewContainer.setLogoutButtonCallback { [weak self] in
            guard let self = self else { return }
            self.logout()
        }
    }
    private func logout() {
           // Kullanıcıyı login ekranına yönlendirme kodu
           let loginViewController = LoginViewController() // LoginViewController'ı initialize et
           loginViewController.modalPresentationStyle = .fullScreen // Tam ekran olmasını sağla
           self.present(loginViewController, animated: true, completion: nil)
       }
    
}
