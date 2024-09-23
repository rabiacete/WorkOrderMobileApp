//
//  InputView.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 16.09.2024.
//

import UIKit
import SnapKit

class InputView: BaseView {
    private let textField = UITextField()

    private let titleLabel = UILabel()
    private let inputTextField = UITextField()
    
    required init() {
        super.init()
        prepare()
        draw()
    }
    func getInputText() -> String {
          return textField.text ?? ""
      }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: InputViewPresentationModel) {
        titleLabel.text = model.title
        inputTextField.placeholder = model.placeholder
        inputTextField.isSecureTextEntry = model.isSecureText
    }
}

extension InputView {
    public func getText() -> String? {
        return inputTextField.text

    }
}


extension InputView{
    func disableAutoFill() {
        inputTextField.textContentType = .oneTimeCode

       }
}

extension InputView {
    private func prepare() {
        backgroundColor = .clear
        titleLabel.textColor = Colors.titleColor.getUIColor()
        titleLabel.font = Fonts.SFProText.medium.getAsFont(with: 14)
        titleLabel.textAlignment = .left
        
        inputTextField.backgroundColor = .white
        inputTextField.layer.cornerRadius = 16
        
 

    }
}

extension InputView {
    private func draw() {
        addArrangedSubview(titleLabel)
        addArrangedSubview(inputTextField)
        
    setSpacing(8)
    
    titleLabel.snp.makeConstraints { make in
        make.height.equalTo(17)
    }
    
    inputTextField.snp.makeConstraints { make in
        make.height.equalTo(50)
    }
    
    }
}

struct InputViewPresentationModel {
    let title: String
    let placeholder: String
    let isSecureText: Bool
}
