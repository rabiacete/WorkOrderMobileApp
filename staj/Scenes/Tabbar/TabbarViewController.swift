// 
//  TabbarViewController.swift
//  staj
//
//  Created by Rabia on 8.09.2024.
//

import Foundation
import UIKit

class TabbarViewController: UITabBarController, TabBarViewDelegate {
    
    
    func tabChanged(_ tabBarView: TabBarView, toIndex: Int) {
        self.selectedIndex = toIndex
    }
    
    private var customTabBar: TabBarView!
    var iconList = [Images]()
    var titleList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .clear
     
        setup()
        
        setViewControllers(TabbarDataProvider.shared.provideTabbarItems().map({$0.controller}), animated: true)    }
    
    func setup() {
        if let bar = customTabBar {
            bar.removeFromSuperview()
        }
        iconList.removeAll()
        titleList.removeAll()
        iconList.append(contentsOf: TabbarDataProvider.shared.provideTabbarItems().map({$0.icon}))
        titleList.append(contentsOf: TabbarDataProvider.shared.provideTabbarItems().map({$0.title}))
        customTabBar = TabBarView(frame: tabBar.frame)
        customTabBar.delegate = self
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.backgroundColor = Colors.tabbarBackground.getUIColor()
        view.addSubview(customTabBar)
        customTabBar.setupIconsAndTitles(iconList: iconList, titleList: titleList)
        customTabBar.backgroundColor = Colors.tabbarBackground.getUIColor()
        NSLayoutConstraint.activate([
            customTabBar.widthAnchor.constraint(equalTo: tabBar.widthAnchor),
            //customTabBar.heightAnchor.constraint(equalTo: tabBar.heightAnchor)
            customTabBar.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: 1),
            customTabBar.topAnchor.constraint(equalTo: tabBar.topAnchor),
            customTabBar.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor)
        ])
    }
 
    func changeTab(toIndex: Int) {
        customTabBar.relocateHorizontalBarWith(indexPath: IndexPath(row: toIndex, section: 0))
        self.selectedIndex = toIndex
    }
    func hideTabbar() {
            tabBar.isHidden = true
            customTabBar.isHidden = true
            customTabBar.removeFromSuperview()
        }
        
        func showTabbar() {
            customTabBar.isHidden = false
            setup()
        }
    
}


