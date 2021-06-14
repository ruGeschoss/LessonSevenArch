//
//  SearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 08.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class SearchModuleBuilder {
  
  static func build() -> (UIViewController & SearchViewInput) {
    let router = SearchRouter()
    let interactor = SearchInteractor()
    let presenter = SearchPresenter(interactor: interactor, router: router)
    let searchController = SearchViewController(presenter: presenter)
    
    presenter.viewInput = searchController
    router.viewController = searchController

    return searchController
  }
  
}
