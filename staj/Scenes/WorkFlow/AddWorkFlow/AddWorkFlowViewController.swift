//
//  AddWorkFlowViewController.swift
//  staj
//
//  Created by Rabia on 19.09.2024.
//

import Foundation

class AddWorkFlowViewController: BaseViewController<AddWorkFlowViewModel, AddWorkFlowView> {
    
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
            case .backTapped:
                self.dismiss(animated: true)
         
            }
        }
    }
    
    private func bindViewCallback() {
        /*viewContainer.setButtonCallback { [weak self] state in
               guard let self = self else { return }
               switch state {
               case .save(let workName, let workCode):
                   self.viewModel.addWorkOrder(name: workName, code: workCode)
               case .back:
                   self.navigationController?.popViewController(animated: true)
               }
           }*/
    }
}
