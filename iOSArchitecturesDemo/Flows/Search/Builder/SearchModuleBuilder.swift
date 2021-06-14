//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 08.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SearchModuleBuilder {
  
  static func build() -> UIViewController {
    let searchService = ITunesSearchService()
    let downloadAppsService = FakeDownloadAppsService()
    let viewModel = SearchViewModel(searchService: searchService, downloadAppsService: downloadAppsService)
    let viewController = SearchViewController(viewModel: viewModel)
    viewModel.viewController = viewController
    return viewController
  }
  
}
