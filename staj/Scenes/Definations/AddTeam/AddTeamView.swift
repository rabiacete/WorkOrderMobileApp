//
//  AddTeamView.swift
//  staj/Users/rabsa/Desktop/untitled folder/uikit/staj/staj/Scenes/Definations/AddItem/AddItemView.swift
//
//  Created by Rabia on 19.09.2024.
//

import UIKit
import SnapKit
enum AddTeamPageButtonStates {
    case back
    case save(teamName: String, TeamCode: String)
}
class AddTeamView: BaseView {
    private let backButton = UIButton()
    private let pageTitleLabel = UILabel()
    private let teamName = InputView()
    private let teamCode = InputView()
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
    
    public func setPresentationModel(model: AddTeamViewModel.PresentationModel) {
        
    }
}

extension AddTeamView {
    public func setButtonCallback(callback: @escaping Callback<AddTeamPageButtonStates>) {
        self.buttonCallback = callback
    }
    // Butona basıldığında tetiklenen aksiyon
      @objc func buttonDidTapped(_ sender: UIButton) {
          // Hangi butona basıldığını anlamak için tag kullanıyoruz
          switch sender.tag {
          case 1:
              // Geri butonuna basıldıysa
              buttonCallback?(.back)
          case 2:
              // Kaydet butonuna basıldıysa
              guard let name = teamName.getText(), let code = teamCode.getText() else {
                  print("Ekip adı veya ekip kodu eksik")
                  return
              }
              buttonCallback?(.save(teamName: name, TeamCode: code))
          default:
              break
          }
      }}

extension AddTeamView {
    private func prepare() {
        backButton.setImage(Images.back.getUIImage(), for: .normal)
        backButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
        backButton.tag = 1
        
        pageTitleLabel.textColor = Colors.titleColor.getUIColor()
        pageTitleLabel.font = Fonts.SFProText.bold.getAsFont(with: 28)
        pageTitleLabel.text = "Ekip Ekle"
        pageTitleLabel.textAlignment = .center
        
        teamName.setPresentationModel(model: .init(title: "Ekip Adı", placeholder: "Ekip Adı Giriniz", isSecureText: false))
        
        teamCode.setPresentationModel(model: .init(title: "Ekip Kodu", placeholder: "Ekip Kodunu Giriniz", isSecureText: false))
        
        saveButton.setTitle("Kayıt Et", for: .normal)
        saveButton.backgroundColor = Colors.primaryColor.getUIColor()
        saveButton.layer.cornerRadius = 16
        saveButton.tag = 2
        saveButton.addTarget(self, action: #selector(buttonDidTapped(_:)), for: .touchUpInside)
    }
}

extension AddTeamView {
    private func draw() {
        let topView = UIView()
        topView.addSubview(backButton)
        topView.addSubview(pageTitleLabel)
        
        addArrangedSubview(topView)
        addArrangedSubview(teamName)
        addArrangedSubview(teamCode)
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
        
        
        teamName.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        teamCode.snp.makeConstraints { make in
            make.height.equalTo(75)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(24)
            
        }
    }
}
