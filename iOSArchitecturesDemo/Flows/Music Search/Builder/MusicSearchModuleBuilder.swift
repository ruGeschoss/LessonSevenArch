//
//  MusicSearchModuleBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class MusicSearchModuleBuilder {
  
  static func build() -> UIViewController & MusicSearchControllerInterface {
    let interactor = MusicSearchInteractor()
    let router = MusicSearchRouter()
    let presenter = MusicSearchPresenter(interactor: interactor, router: router)
    let controller = MusicSearchViewController(presenter: presenter)
    presenter.controller = controller
    router.controller = controller
    return controller
  }
  
}
