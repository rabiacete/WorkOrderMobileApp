//
//  ProfileView.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import UIKit
import SnapKit

class ProfileView: BaseView {
    private let logoutButton = UIButton()
    
    private var logoutButtonCallback: (() -> Void)?

    
    required init() {
        super.init()
        prepare()
        draw()
        
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: ProfileViewModel.PresentationModel) {
        
    }
}

extension ProfileView {
   
}
extension ProfileView {
    private func prepare() {
        // Çıkış butonunun özelliklerini ayarla
          logoutButton.setTitle("Çıkış Yap", for: .normal)
          logoutButton.backgroundColor = .red
          logoutButton.layer.cornerRadius = 8    }
}
extension ProfileView {
    private func draw() {
        // Çıkış butonunu görünüm hiyerarşisine ekle
        addSubview(logoutButton)
        
        // SnapKit ile konumlandırma
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().offset(-50) // Ekranın alt kısmına yerleştir
        }
        
        // Logout butonu için hedefi ekle
                logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
            }
    
    // Çıkış butonuna dışarıdan erişim için fonksiyon
        public func setLogoutButtonCallback(callback: @escaping () -> Void) {
            logoutButton.addTarget(nil, action: #selector(logoutTapped), for: .touchUpInside)
            self.logoutButtonCallback = callback
        }

        // Butona tıklama işlemi
        @objc private func logoutTapped() {
            logoutButtonCallback?()
        }
        
}
