//
//  RegisterView.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import UIKit
import SnapKit
import SVProgressHUD

enum RegisterPageButtonStates {
    case back
    case register(email: String, password: String, passwordConfirm: String)
}

class RegisterView: BaseView {
    
    private let backButton = UIButton()
    private let pageTitleLabel = UILabel()
    
    private let nameInputView = InputView()
    private let emailInputView = InputView()
    private let passwordInputView = InputView()
    private let passwordConfirmInputView = InputView()
    private let registerButton = UIButton()
    
    var buttonCallback: Callback<RegisterPageButtonStates>?
   
    required init() {
        super.init()
        prepare()
        draw()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: RegisterViewModel.PresentationModel) {
        
    }
}

extension RegisterView {
    
    public func setButtonCallback(callback: @escaping Callback<RegisterPageButtonStates>) {
        self.buttonCallback = callback
    }
    
    // E-posta doğrulaması için fonksiyon
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    // Şifre uzunluğu kontrolü için fonksiyon
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 6
    }
    
    @objc func buttonDidTapped(_ sender: UIButton) {
         if sender.tag == 1 {
              buttonCallback?(.back)
          } else if sender.tag == 2 {
              let email = emailInputView.getText() ?? ""
              let password = passwordInputView.getText() ?? ""
              let passwordConfirm = passwordConfirmInputView.getText() ?? ""
              
              // Şifrelerin eşit olup olmadığını kontrol et
              if password != passwordConfirm {
                  SVProgressHUD.showError(withStatus: "Şifreler uyuşmuyor!")
                  return
              }
              
              // E-posta doğrulaması
              if !isValidEmail(email) {
                  SVProgressHUD.showError(withStatus: "Geçerli bir e-posta adresi girin!")
                  return
              }
                      
             // Şifre uzunluğu kontrolü
                      if !isValidPassword(password) {
                          SVProgressHUD.showError(withStatus: "Şifreniz en az 6 karakter olmalı!")
                          return
                      }
              
              buttonCallback?(.register(email: email, password: password, passwordConfirm: passwordConfirm))
          }
      }
}
extension RegisterView {
    private func prepare() {
        backButton.setImage(Images.back.getUIImage(), for: .normal)
        backButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        backButton.tag = 1
        
        pageTitleLabel.textColor = Colors.titleColor.getUIColor()
        pageTitleLabel.font = Fonts.SFProText.bold.getAsFont(with: 30)
        pageTitleLabel.text = "Kayıt Ol"
        pageTitleLabel.textAlignment = .center
        
        nameInputView.setPresentationModel(model: .init(title: "İsim", placeholder: "Adınızı girin", isSecureText: false))
        emailInputView.setPresentationModel(model: .init(title: "E-Posta Adresi", placeholder: "example@mail.com", isSecureText: false))
        
        passwordInputView.setPresentationModel(model: .init(title: "Şifre", placeholder: "Şifrenizi girin", isSecureText: true))
        passwordConfirmInputView.setPresentationModel(model: .init(title: "Şifre Tekrar", placeholder: "Şifrenizi tekrar girin", isSecureText: true))
        
        registerButton.setTitle("Kayıt Ol", for: .normal)
        registerButton.backgroundColor = Colors.primaryColor.getUIColor()
        registerButton.layer.cornerRadius = 16
        registerButton.tag = 2
        registerButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
    }
}

extension RegisterView {
    private func draw() {
    
        let topView = UIView()
        topView.addSubview(backButton)
        topView.addSubview(pageTitleLabel)

        addArrangedSubview(topView)
        addArrangedSubview(nameInputView)
        addArrangedSubview(emailInputView)
        addArrangedSubview(passwordInputView)
        addArrangedSubview(passwordConfirmInputView)
    
        // Kayıt ol butonundan önce boşluğu ayarlama
        let emptyView = UIView()
        addArrangedSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(100)  // Boşluk yüksekliği
        }
        
        addArrangedSubview(registerButton)
        setSpacing(16)
        
        pageTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
        }
        
        topView.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
       
        nameInputView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(24)
        }
                
        emailInputView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(24)
        }
                
        passwordInputView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(24)
        }
                
        passwordConfirmInputView.snp.makeConstraints { make in
            make.height.equalTo(75)  // Şifre giriş boyutunda olması için aynı yükseklik
            make.leading.trailing.equalToSuperview().inset(24)
        }

        registerButton.snp.makeConstraints { make in
           make.height.equalTo(50)
           make.leading.trailing.equalToSuperview().inset(24)
              
        }
    }
}

