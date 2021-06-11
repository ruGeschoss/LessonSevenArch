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
    let presenter = MusicSearchPresenter()
    let controller = MusicSearchViewController(presenter: presenter)
    presenter.controller = controller
    return controller
  }
  
}
