//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppStartManager {
  
  private enum Constants {
    static let appSearchTabBarItem = UITabBarItem(title: "Apps",
                                                  image: nil,
                                                  selectedImage: nil)
    static let musicSearchTabBarItem = UITabBarItem(title: "Music",
                                                    image: nil,
                                                    selectedImage: nil)
  }
  
  var window: UIWindow?
  
  init(window: UIWindow?) {
    self.window = window
  }
  
  func start() {
    let navVC = createNavController()
    let navVC2 = createNavController()
    
    let musicVC = MusicSearchModuleBuilder.build()
    let appsVC = SearchModuleBuilder.build()
    
    navVC.viewControllers = [musicVC]
    navVC2.viewControllers = [appsVC]
    navVC.tabBarItem = Constants.musicSearchTabBarItem
    navVC2.tabBarItem = Constants.appSearchTabBarItem
    
    let tabbar = UITabBarController()
    tabbar.viewControllers = [navVC, navVC2]
    tabbar.tabBar.tintColor = .white
    tabbar.tabBar.barTintColor = .black
    
    window?.rootViewController = tabbar
    window?.makeKeyAndVisible()
  }
  
  private func createNavController() -> UINavigationController {
    let navVC = UINavigationController()
    navVC.navigationBar.barTintColor = UIColor.varna
    navVC.navigationBar.isTranslucent = false
    navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    return navVC
  }
}
