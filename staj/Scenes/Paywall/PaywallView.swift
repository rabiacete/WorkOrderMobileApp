// 
//  PaywallView.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit
import SnapKit

class PaywallView: BaseView {
    
    required init() {
        super.init()
        prepare()
        draw()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: PaywallViewModel.PresentationModel) {
        
    }
}

extension PaywallView {
    
}

extension PaywallView {
    private func prepare() {
        
    }
}

extension PaywallView {
    private func draw() {
        
        let button1 = UIButton()
        button1.setTitle("ekle", for: .normal)
        button1.tag = 2
        button1.backgroundColor = .red
        button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        self.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        AuthManager.shared.signOut {
            
        }
    }
}

