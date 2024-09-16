// 
//  OnboardingViewModel.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation

protocol OnboardingViewModelProtocol: BaseViewModelProtocol, ObserveManageable where ActionType == OnboardingViewModel.OnboardingAction {
    func nextButtonPressed()
    func skipButtonPressed()
}

class OnboardingViewModel: BaseViewModel, OnboardingViewModelProtocol, ActionSendable {
    
    enum OnboardingAction {
        case presentationModel(PresentationModel)
        case currentPageModel(PageModel)
        case openTabbar
    }
    
    struct PageModel {
        let title: AppStrings
        let description: AppStrings
        let image: Images
        let index: Int
    }
    
    struct PresentationModel {
        let skipButtonTitle: AppStrings
        let nextButtonTitle: AppStrings
        let totalPages: Int
    }
    
    var observer: Callback<OnboardingAction>!
    
    private var pageModels: [PageModel] = []
    
    private var pageIndex: Int = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        preparePageModel()
        sendAction(.presentationModel(.init(skipButtonTitle: .skip, nextButtonTitle: .next, totalPages: pageModels.count)))
        sendAction(.currentPageModel(pageModels[pageIndex]))
    }
    
    func preparePageModel() {
        let page1 = PageModel(title: AppStrings.onboardingTitlePageOne,
                              description: AppStrings.onboardingDescriptionPageOne,
                              image: Images.star,
                              index: 0)
        
        let page2 = PageModel(title: AppStrings.onboardingTitlePageTwo,
                              description: AppStrings.onboardingDescriptionPageTwo,
                              image: Images.star,
                              index: 1)
        
        let page3 = PageModel(title: AppStrings.onboardingTitlePageThree,
                              description: AppStrings.onboardingDescriptionPageThree,
                              image: Images.star,
                              index: 2)
        
        pageModels = [page1, page2, page3]
    }
    
    func nextButtonPressed() {
        if pageIndex < pageModels.count - 1 {
            pageIndex += 1
            let model = pageModels[pageIndex]
            sendAction(.currentPageModel(model))
        } else {
            sendAction(.openTabbar)
        }
    }
    
    func skipButtonPressed() {
        sendAction(.openTabbar)
    }
}

