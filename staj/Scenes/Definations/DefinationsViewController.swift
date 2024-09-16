//
//  DefinationsViewController.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation

class DefinationsViewController: BaseViewController<DefinationsViewModel, DefinationsView> {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        bindViewModel()
        super.viewDidLoad()
        bindViewCallback()
    }
    
    private func bindViewModel() {
        viewModel.observer = { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .presentationModel(let model):
                self.viewContainer.setPresentationModel(model: model)
            }
        }
    }
    
    private func bindViewCallback() {
        
    }
}
