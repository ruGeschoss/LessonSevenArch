//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 14.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterInput {
  
  func openDetails(for app: ITunesApp)
  func openAppInITunes(_ app: ITunesApp)
}

final class SearchRouter: SearchRouterInput {
  
  weak var viewController: UIViewController?
  
  func openDetails(for app: ITunesApp) {
    let appDetaillViewController = AppDetailViewController(app: app)
    self.viewController?.navigationController?.pushViewController(appDetaillViewController, animated: true)
  }
  
  func openAppInITunes(_ app: ITunesApp) {
    guard let urlString = app.appUrl, let url = URL(string: urlString) else {
      return
    }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
}
