//
//  AddStateViewController.swift
//  staj
//
//  Created by Rabia on 19.09.2024.
//

import Foundation

class AddStateViewController: BaseViewController<AddStateViewModel, AddStateView> {
    
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
