//
//  AddTeamViewModel.swift
//  staj
//
//  Created by Rabia on 19.09.2024.
//

import Foundation
import FirebaseFirestoreInternal
import FirebaseFirestore
protocol AddTeamViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == AddTeamViewModel.AddTeamAction {
}

class AddTeamViewModel: BaseViewModel {
    enum AddTeamAction {
        case presentationModel(PresentationModel)
        case backTapped
    }
    struct PresentationModel {
        
    }
    var observer: Callback<AddTeamAction>!
    private let db = Firestore.firestore()  // Firestore veritabanına referans
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // Firebase'e yeni ekip eklemek için fonksiyon
       func addTeam(name: String, code: String) {
           let teamData: [String: Any] = [
               "teamName": name,
               "teamCode": code,
               "createdAt": Timestamp()
           ]
    
           // Firestore'da "teams" koleksiyonuna veri ekleme
                db.collection("teams").addDocument(data: teamData) { error in
                    if let error = error {
                        print("Ekip eklenirken hata oluştu: \(error.localizedDescription)")
                    } else {
                        print("Ekip başarıyla eklendi!")
                    }
                }
            }
    func saveTeamToFirebase(name: String, code: String) {
        // Firestore referansı
        let db = Firestore.firestore()

        var onTeamSaved: (() -> Void)? // Ekip kaydedildiğinde çağrılacak kapanış

        func saveTeam(name: String, code: String) {
            // Firebase'e kaydetme işlemi
            let team = Team(name: name, code: code)

            // Firebase'e kaydetme işlemi burada yapılmalı

            // Kaydetme işlemi başarılıysa
            onTeamSaved?() // Kapanışı çağır
        }
        
        
        // Firestore'a kaydedilecek veri
        let teamData: [String: Any] = [
            "teamName": name,
            "teamCode": code,
            "createdAt": Timestamp(date: Date()) // Firestore Timestamp ile veri oluşturma zamanı
        ]

        // Firestore'da "teams" koleksiyonuna veri ekleme
        db.collection("teams").addDocument(data: teamData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully!")
            }
        }
    }

    
}
