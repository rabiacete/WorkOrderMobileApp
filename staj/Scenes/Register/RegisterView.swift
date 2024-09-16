//
//  RegisterView.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import UIKit
import SnapKit

enum RegisterPageButtonStates {
    case back
    case register(email: String, password: String, passwordConfirm: String)
}

class RegisterView: BaseView {
    
    private let backButton = UIButton()
    private let pageTitleLabel = UILabel()
    
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
    
    @objc func buttonDidTapped(_ sender: UIButton) {
        if sender.tag == 1 {
            buttonCallback?(.back)
            return
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
    }
}

extension RegisterView {
    private func draw() {
        let topView = UIView()
        topView.addSubview(backButton)
        topView.addSubview(pageTitleLabel)
        topView.backgroundColor = .red
        
        addArrangedSubview(topView)
        addArrangedSubview(UIView())
        
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
        
    }
}
