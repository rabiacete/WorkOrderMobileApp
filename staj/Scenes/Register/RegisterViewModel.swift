//
//  RegisterViewModel.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation
import FirebaseAuth
import SVProgressHUD
protocol RegisterViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == RegisterViewModel.RegisterAction {
}

class RegisterViewModel: BaseViewModel, ActionSendable {
    enum RegisterAction {
        case presentationModel(PresentationModel)
        case backTapped
        case showSuccessMessage(String) // Yeni durum eklenmiş
        case showErrorMessage(String)
  
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
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                // Kayıt hatası
                print("Kayıt hatası: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                // Kayıt başarılı mesajını göster
                self?.sendAction(.showSuccessMessage("Kayıt başarılı!"))
                
                // Başarılı mesajı gösterildikten sonra login ekranına dön
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                    self?.sendAction(.backTapped)
                }
            }}}}


