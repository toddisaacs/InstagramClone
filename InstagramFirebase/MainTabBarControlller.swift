//
//  MainTabBarControlller.swift
//  InstagramFirebase
//
//  Created by Isaacs, Todd (CAI - Carmel) on 10/10/18.
//  Copyright © 2018 Isaacs, Todd. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let layout = UICollectionViewFlowLayout()
    let userProfileController = UserProfileController(collectionViewLayout: layout)
    let navController = UINavigationController(rootViewController: userProfileController)
    
    navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
    navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
    
    tabBar.tintColor = .black
    
    viewControllers = [navController, UIViewController()]
    
  }
}
