//
//  MainTabBarController.swift
//  MediaProject
//
//  Created by Eunbee Kang on 2023/08/27.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        let mainVC = TrendingAllViewController()
        mainVC.tabBarItem = UITabBarItem(
            title: "Trending",
            image: UIImage(systemName: "doc.text.image"),
            selectedImage: UIImage(systemName: "doc.text.image.fill")
        )
        let mainTab = UINavigationController(rootViewController: mainVC)
        
        let firstVC = TrendingViewController()
        firstVC.tabBarItem = UITabBarItem(
            title: "Movie",
            image: UIImage(systemName: "theatermasks"),
            selectedImage: UIImage(systemName: "theatermasks.fill")
        )
        let firstTab = UINavigationController(rootViewController: firstVC)
        
        let secondVC = TVShowViewController()
        secondVC.tabBarItem = UITabBarItem(
            title: "TV Show",
            image: UIImage(systemName: "sparkles.tv"),
            selectedImage: UIImage(systemName: "sparkles.tv.fill")
        )
        let secondTab = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = ProfileViewController()
        thirdVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        let thirdTab = UINavigationController(rootViewController: thirdVC)
        
        setViewControllers([mainTab, firstTab, secondTab, thirdTab], animated: false)
    }
}
