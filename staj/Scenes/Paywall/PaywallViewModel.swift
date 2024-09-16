// 
//  PaywallViewModel.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

class PaywallViewModel: BaseViewModel {
    
    struct PresentationModel {
        
    }
    
    var presentationModel = Observable<PresentationModel>()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentationModel.value = .init()
    }
}
