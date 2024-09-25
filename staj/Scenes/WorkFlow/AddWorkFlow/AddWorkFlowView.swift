//
//  AddWorkFlowView.swift
//  staj
//
//  Created by Rabia on 19.09.2024.
//

import UIKit
import SnapKit
enum AddWorkFlowPageButtonStates {
    case back
    case save(teamName: String, TeamCode: String)
}
class AddWorkFlowView: BaseView {
    private let backButton = UIButton()
    private let pageTitleLabel = UILabel()
    private let workName = InputView()
    private let workCode = InputView()
    private let saveButton = UIButton()
    

    
    var buttonCallback: Callback<AddTeamPageButtonStates>?
    required init() {
        super.init()
        prepare()
        draw()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: AddWorkFlowViewModel.PresentationModel) {
        
    }
}

extension AddWorkFlowView {
    public func setButtonCallback(callback: @escaping Callback<AddTeamPageButtonStates>) {
        self.buttonCallback = callback
    }
    @objc func buttonDidTapped(_ sender: UIButton)
    {
    
    }
}

extension AddWorkFlowView {
    private func prepare() {
        backButton.setImage(Images.back.getUIImage(), for: .normal)
        backButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        backButton.tag = 1
        pageTitleLabel.textColor = Colors.titleColor.getUIColor()
        pageTitleLabel.font = Fonts.SFProText.bold.getAsFont(with: 28)
        pageTitleLabel.text = "İş Emri Ekle"
        pageTitleLabel.textAlignment = .center
        workName.setPresentationModel(model: .init(title: "İŞ Adı", placeholder: "İŞ Adı Giriniz", isSecureText: false))
        workCode.setPresentationModel(model: .init(title: "İŞ Kodu", placeholder: "İŞ Kodunu Giriniz", isSecureText: false))
        saveButton.setTitle("Kayıt Et", for: .normal)
        saveButton.backgroundColor = Colors.primaryColor.getUIColor()
        saveButton.layer.cornerRadius = 16
        saveButton.tag = 2
        saveButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
    }
}

extension AddWorkFlowView {
    private func draw() {
        let topView = UIView()
        topView.addSubview(backButton)
        topView.addSubview(pageTitleLabel)
        
        addArrangedSubview(topView)
        addArrangedSubview(workName)
        addArrangedSubview(workCode)
        addArrangedSubview(UIView())
        addArrangedSubview(saveButton)
        
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
        
        
        workName.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        workCode.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(24)
            
        }
    }
}
