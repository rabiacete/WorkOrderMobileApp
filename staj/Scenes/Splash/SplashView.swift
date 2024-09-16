// 
//  SplashView.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit
import SnapKit

class SplashView: BaseView {
    
    let containerView = UIView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    required init() {
        super.init()
        prepare()
        draw()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: SplashViewModel.PresentationModel) {
        imageView.image = model.logo.getUIImage()
        titleLabel.text = model.appName.localizedString
    }
}

extension SplashView {
    
}

extension SplashView {
    private func prepare() {
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.font = Fonts.SFProText.bold.getAsFont(with: 36)
        titleLabel.textColor = Colors.primaryColor.getUIColor()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
}

extension SplashView {
    private func draw() {
        self.addArrangedSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(250)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(35)
        }
    }
}

