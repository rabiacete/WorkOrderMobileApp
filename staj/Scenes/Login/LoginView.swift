//
//  LoginView.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 16.09.2024.
//

import UIKit
import SnapKit
import SVProgressHUD

enum LoginPageButtonStates {
    case login(email: String, password: String)
    case register
}

class LoginView: BaseView {
    
    private let pageTitleLabel = UILabel()
    private let phoneInputView = InputView()
    private let passwordInputView = InputView()
    private let loginButton = UIButton()
    private let registerButton = UIButton()
    var buttonCallback: Callback<LoginPageButtonStates>?
    required init() {
        super.init()
        prepare()
        draw()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func setPresentationModel(model: LoginViewModel.PresentationModel) {
    }
}

extension LoginView {
    public func setButtonCallback(callback: @escaping Callback<LoginPageButtonStates>) {
        self.buttonCallback = callback
    }
    
    @objc func buttonDidTapped(_ sender: UIButton) {
        loginButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)

        if sender.tag == 1 {
            buttonCallback?(.register)
            return
        }
        
        guard let email = phoneInputView.getText(), let password = passwordInputView.getText() else { return }
        
        buttonCallback?(.login(email: email, password: password))
    }
    
    public func showLoginError() {
        SVProgressHUD.showError(withStatus: "Giriş bilgileriniz yanlış. Tekrar deneyiniz")
    }
}

extension LoginView {
    private func prepare() {
        backgroundColor = Colors.backgroundColor.getUIColor()
        pageTitleLabel.textColor = Colors.titleColor.getUIColor()
        pageTitleLabel.font = Fonts.SFProText.bold.getAsFont(with: 30)
        pageTitleLabel.text = "Giriş Yap"
        pageTitleLabel.textAlignment = .center
        
        let data1 = InputViewPresentationModel(title: "E-Mail Adresi", placeholder: "user@example.com", isSecureText: false)
        let data2 = InputViewPresentationModel(title: "Şifre", placeholder: "********", isSecureText: true)
        
        phoneInputView.setPresentationModel(model: data1)
        passwordInputView.setPresentationModel(model: data2)
        
        loginButton.backgroundColor = Colors.primaryColor.getUIColor()
        loginButton.setTitleColor(Colors.titleColor.getUIColor(), for: .normal)
        loginButton.setTitle("Giriş Yap", for: .normal)
        loginButton.titleLabel?.font = Fonts.SFProText.bold.getAsFont(with: 21)
        loginButton.layer.cornerRadius = 16
        loginButton.tag = 0
        loginButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        
        registerButton.backgroundColor = .clear
        registerButton.setTitleColor(Colors.primaryColor.getUIColor(), for: .normal)
        registerButton.setTitle("Kayıt Ol", for: .normal)
        registerButton.titleLabel?.font = Fonts.SFProText.bold.getAsFont(with: 21)
        registerButton.tag = 1
        registerButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        
    }
}

extension LoginView {
    private func draw() {
        addArrangedSubview(pageTitleLabel)
        addSpacing(spacing: 100, after: pageTitleLabel)
        addArrangedSubview(phoneInputView)
        addArrangedSubview(passwordInputView)
        addArrangedSubview(UIView())
        addArrangedSubview(loginButton)
        addArrangedSubview(registerButton)
        
        setSpacing(16)
        
        pageTitleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
        }
        
        phoneInputView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(23)
        }
        
        passwordInputView.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(23)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(23)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(23)
        }
    }
}
