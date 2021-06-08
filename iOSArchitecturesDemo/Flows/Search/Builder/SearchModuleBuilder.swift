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
    let presenter = SearchPresenter()
    let searchController = SearchViewController(presenter: presenter)
    presenter.viewInput = searchController
    return searchController
  }
  
}
