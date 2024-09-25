//
//  AddTeamViewController.swift
//  staj
//
//  Created by Rabia on 19.09.2024.
//

import Foundation
import UIKit
import FirebaseFirestore
class AddTeamViewController: BaseViewController<AddTeamViewModel, AddTeamView> {
    
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
        viewContainer.setButtonCallback { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .save(let teamName, let teamCode):
                // ViewModel üzerinden Firebase'e ekip eklenmesini sağla
                self.viewModel.addTeam(name: teamName, code: teamCode)
            case .back:
                self.dismiss(animated: true)
            }
        }}
     func saveTeamToFirebase(name: String, code: String) {
            let db = Firestore.firestore()

            let teamData: [String: Any] = [
                "teamName": name,
                "teamCode": code,
                "createdAt": Timestamp(date: Date())
            ]

            db.collection("teams").addDocument(data: teamData) { error in
                if let error = error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully!")
                }
            }
        }
    }
                
                

            
    

