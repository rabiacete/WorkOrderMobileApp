//
//  DefinationsViewModel.swift
//  staj
//
//  Created by Alperen Polat Gezgin on 17.09.2024.
//

import Foundation
import FirebaseFirestoreInternal


protocol DefinationsViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == DefinationsViewModel.DefinationsAction {

}

class DefinationsViewModel: BaseViewModel, ActionSendable {
    
    enum DefinationsAction {
        case presentationModel(PresentationModel)
    }
    
    struct PresentationModel {
        let teams: [Team] // Team modelini ekleyin
        
    }
    
    var observer: Callback<DefinationsAction>!
    private var teams: [Team] = [] // Kayıtlı ekipleri tutan dizi
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
             }
    }
    
 
       

