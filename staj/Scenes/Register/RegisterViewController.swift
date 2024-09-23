//
//  RegisterViewController.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//
import Foundation
import UIKit

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
            case .showSuccessMessage(let message):
                self.showSuccessAlert(message: message)
                self.presentScene(scene: .tabbar, animated: true)
            case .showErrorMessage(let message): // Hata mesajını göster
                self.showErrorAlert(message: message)
            
            }
        }
    }
    
 

    private func showSuccessAlert(message: String) {
        let alert = UIAlertController(title: "Başarılı", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(message: String) {
       let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Tamam", style: .default))
       present(alert, animated: true, completion: nil)
   }
    
    private func navigateToLogin() {
         let loginViewController = LoginViewController() // Login sayfasını oluştur
         navigationController?.pushViewController(loginViewController, animated: true) // Yönlendirme
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


