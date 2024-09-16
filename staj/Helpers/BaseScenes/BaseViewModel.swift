// 
//  BaseViewModel.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

public protocol BaseViewModelProtocol: AnyObject {
    init(_ className: String)
    init()
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidAppear()
    var viewControllerName: String? { get }
}

class BaseViewModel: BaseViewModelProtocol {
    var viewControllerName: String?
    
    required init(_ viewControllerName: String){
        self.viewControllerName = viewControllerName
    }
    
    required init(){
    }
    
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewWillDisappear() {}
    func viewDidAppear() {}
}
