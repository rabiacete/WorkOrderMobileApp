// 
//  OnboardingView.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit
import SnapKit

class OnboardingView: BaseView {
    
    let containerView = UIView()
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let continueButton = UIButton()
    let skipButton = UIButton()
    let pageControl = UIPageControl()
    
    
    var skipButtonAction: CallbackVoid?
    var continueButtonAction: CallbackVoid?
    
    required init() {
        super.init()
        prepare()
        draw()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPresentationModel(model: OnboardingViewModel.PresentationModel) {
      
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self else { return }
            self.skipButton.alpha = 0.0
            self.skipButton.transform = CGAffineTransform(translationX: 0, y: -20)
            
            self.continueButton.alpha = 0.0
            self.continueButton.transform = CGAffineTransform(translationX: 0, y: -20)
            
            self.pageControl.alpha = 0.0
            self.pageControl.transform = CGAffineTransform(translationX: 0, y: -20)
        }) { [weak self] _ in
            guard let self else { return }
            self.skipButton.setTitle(model.skipButtonTitle.localizedString, for: .normal)
            self.skipButton.transform = CGAffineTransform(translationX: 0, y: 20)
            
            self.continueButton.setTitle(model.nextButtonTitle.localizedString, for: .normal)
            self.continueButton.transform = CGAffineTransform(translationX: 0, y: 20)
            
            self.pageControl.numberOfPages = model.totalPages
            self.pageControl.transform = CGAffineTransform(translationX: 0, y: 20)
            
            UIView.animate(withDuration: 0.5) {
                self.skipButton.alpha = 1.0
                self.skipButton.transform = .identity
                
                self.continueButton.alpha = 1.0
                self.continueButton.transform = .identity
                
                self.pageControl.alpha = 1.0
                self.pageControl.transform = .identity
            }
        }
    }
    
    public func setCurrentPageModel(model: OnboardingViewModel.PageModel) {
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self else { return }
            self.imageView.alpha = 0.0
            self.imageView.transform = CGAffineTransform(translationX: 0, y: -20)
            
            self.titleLabel.alpha = 0.0
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -20)
            
            self.descriptionLabel.alpha = 0.0
            self.descriptionLabel.transform = CGAffineTransform(translationX: 0, y: -20)
        }) { [weak self] _ in
            guard let self else { return }
            self.imageView.image = model.image.getUIImage()
            self.imageView.transform = CGAffineTransform(translationX: 0, y: 20)
            
            self.titleLabel.text = model.title.localizedString
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: 20)
            
            self.descriptionLabel.text = model.description.localizedString
            self.descriptionLabel.transform = CGAffineTransform(translationX: 0, y: 20)
            
            self.pageControl.currentPage = model.index
            
            UIView.animate(withDuration: 0.5) {
                self.imageView.alpha = 1.0
                self.imageView.transform = .identity
                
                self.titleLabel.alpha = 1.0
                self.titleLabel.transform = .identity
                
                self.descriptionLabel.alpha = 1.0
                self.descriptionLabel.transform = .identity
            }
        }
    }
}

extension OnboardingView {
    public func setSkipButtonAction(action: @escaping CallbackVoid) {
        skipButtonAction = action
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func skipButtonPressed() {
        skipButtonAction?()
    }
    
    public func setContinueButtonAction(action: @escaping CallbackVoid) {
        continueButtonAction = action
        continueButton.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func continueButtonPressed() {
        continueButtonAction?()
    }
    
}

extension OnboardingView {
    private func prepare() {
        skipButton.setTitleColor(Colors.primaryColor.getUIColor(), for: .normal)
        skipButton.titleLabel?.font = Fonts.SFProText.bold.getAsFont(with: 18)
        
        titleLabel.textColor = Colors.titleColor.getUIColor()
        titleLabel.font = Fonts.SFProText.bold.getAsFont(with: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        descriptionLabel.textColor = Colors.captionColor.getUIColor()
        descriptionLabel.font = Fonts.SFProText.regular.getAsFont(with: 18)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        
        continueButton.backgroundColor = Colors.primaryColor.getUIColor()
        continueButton.setTitleColor(Colors.backgroundColor.getUIColor(), for: .normal)
        continueButton.titleLabel?.font = Fonts.SFProText.bold.getAsFont(with: 18)
        continueButton.layer.cornerRadius = 16
        
        pageControl.tintColor = Colors.primaryColor.getUIColor()
        pageControl.currentPageIndicatorTintColor = Colors.primaryColor.getUIColor()
        pageControl.pageIndicatorTintColor = Colors.captionColor.getUIColor()
        
        imageView.contentMode = .scaleAspectFit
        
        continueButton.alpha = 0.0
        
    }
}

extension OnboardingView {
    private func draw() {
        self.addArrangedSubview(containerView)
        
        containerView.addSubview(skipButton)
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(continueButton)
        containerView.addSubview(pageControl)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(skipButton.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(32)
            make.height.equalTo(60)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(75)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(32)
            make.bottom.equalToSuperview().offset(-24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
        
    }
}

