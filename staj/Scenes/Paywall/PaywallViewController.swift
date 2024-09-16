// 
//  PaywallViewController.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

class PaywallViewController: BaseViewController<PaywallViewModel,PaywallView> {
    
    override func viewDidLoad() {
        bindViewModel()
        super.viewDidLoad()
        bindViewCallback()
    }
    
    private func bindViewModel() {
        viewModel.presentationModel.bind { [weak self] model in
            guard let self else { return }
            self.viewContainer.setPresentationModel(model: model)
        }
    }
    
    private func bindViewCallback() {
        
    }
}

