//
//  WorkFlowViewController.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation

class WorkFlowViewController: BaseViewController<WorkFlowViewModel, WorkFlowView> {
    
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
        }}
    private func bindViewCallback() {
        // View tarafında callback tetiklenince burası çalışacak
        viewContainer.setButtonCallback { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .openAddWorkFlowView:
                self.presentAddWorkFlowView()
            }
        }
    }
    
    
    private func presentAddWorkFlowView() {
            let addWorkFlowVC = AddWorkFlowViewController() // AddWorkFlowViewController oluşturuluyor
            self.navigationController?.pushViewController(addWorkFlowVC, animated: true) // Yeni ekran push ediliyor
        }
}
