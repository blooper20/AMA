//
//  CustomTabBarController.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/14.
//

import UIKit
import SnapKit

class CustomTabBarController: UITabBarController {
    
    //MARK: - Declaration
        let mapVC = MapViewController()
        let aedVC = AEDWebViewController()

    //MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        setTabBar()
    }
}

extension CustomTabBarController {
    
    private func configureTapBarItem(tab: UIViewController, title: String, image: String, tag: Int) {
        tab.title = title
        let emojiConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .medium)
        tab.tabBarItem.image = UIImage(systemName: image, withConfiguration: emojiConfig)
        tab.tabBarItem.tag = tag
       }
    
    private func setTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemGreen
        
        configureTapBarItem(tab: mapVC, title: "AED 지도", image: "map.circle.fill", tag: 0)
        configureTapBarItem(tab: aedVC, title: "AED 사용법", image: "heart.text.square.fill", tag: 1)
        
        self.setViewControllers([mapVC, aedVC], animated: true)
    }
}

//MARK: - Delegate
extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
