// 
//  Windows.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

public final class WindowContainer {
    public static var window: UIWindow?
}



public enum Scenes {
    case splash
    case onboarding
    case paywall
    case tabbar
    case tab1
    case tab2
    case tab3
    
    var controller: UIViewController {
        switch self {
        case .splash:
            return SplashViewController()
        case .onboarding:
            return OnboardingViewController()
        case .paywall:
            return PaywallViewController()
        case .tabbar:
            return TabbarViewController()
        case .tab1:
            return PaywallViewController()
        case .tab2:
            return PaywallViewController()
        case .tab3:
            return PaywallViewController()
        }
    }
}

public protocol RouterProtocol {
    func presentScene(scene: Scenes, animated: Bool, _ completion: CallbackVoid?)
    func dismiss(animated: Bool)
    func presentAsChild(scene: Scenes)
    func showPopupAnimate()
    func removePopupAnimate()
    func showSlideAnimate()
    func removeSlideAnimate()
}

extension BaseViewController: RouterProtocol {
    
    public func presentScene(scene: Scenes, animated: Bool, _ completion: CallbackVoid? = nil) {
        let controller = scene.controller
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: animated, completion: {
                completion?()
        })
    }
    
    public func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
    
    public func presentAsChild(scene: Scenes) {
        if let tabbar = self.tabBarController as? TabbarViewController {
            tabbar.hideTabbar()
        }
        let vc = scene.controller
        addChild(vc)
        vc.view.frame = self.view.frame
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
    public func showPopupAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    public func removePopupAnimate() {
        UIView.animate(withDuration: 0.25, animations:  {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool) in
            if (finished) {
                self.view.removeFromSuperview()
            }
        })
    }
    
    public func showSlideAnimate() {
        self.view.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25) {
            self.view.alpha = 1.0
            self.view.transform = .identity
        }
    }
    
    public func removeSlideAnimate() {
        UIView.animate(withDuration: 0.25, animations:  {
            self.view.transform = CGAffineTransform(translationX: -self.view.bounds.width, y: 0)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool) in
            if (finished) {
                if let tabbar = self.tabBarController as? TabbarViewController {
                    tabbar.showTabbar()
                }
                self.view.removeFromSuperview()
            }
        })
    }
}
