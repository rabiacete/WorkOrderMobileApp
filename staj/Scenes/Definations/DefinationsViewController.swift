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
        viewContainer.setAddButtonCallback { [weak self] state in
            guard let self else { return }
            switch state {
            case .team:
                self.presentScene(scene: .addTeam, animated: true)
            case .item:
                self.presentScene(scene: .addItem, animated: true)
            case .state:
                self.presentScene(scene: .addState, animated: true)
            }
        }
    }
}
