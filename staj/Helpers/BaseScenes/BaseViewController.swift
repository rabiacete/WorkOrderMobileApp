// 
//  BaseViewController.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import UIKit

protocol BaseViewControllerProtocol {
    associatedtype T
    associatedtype G
    var viewModel: T! { get set }
    var viewContainer: G! { get set }
}

class BaseViewController<T: BaseViewModelProtocol, G: BaseView>: UIViewController, BaseViewControllerProtocol {
    
    var viewControllerName: String {
        return NSStringFromClass(type(of: self))
    }
    var viewModel: T!
    var viewContainer: G!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.viewModel = T.init(viewControllerName)
        self.viewContainer = G.init()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        self.viewModel = T.init(viewControllerName)
        self.viewContainer = G.init()
    }
    
    open override func loadView() {
        view = viewContainer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
}
