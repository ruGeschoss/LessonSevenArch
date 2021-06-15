//
//  MusicSearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 15.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol MusicSearchRouterInterface {
  func pushMusicPlayer()
}

final class MusicSearchRouter: MusicSearchRouterInterface {

  weak var controller: UIViewController?

  func pushMusicPlayer() {
    let musicVC = UIViewController()
    controller?.present(musicVC, animated: true)
  }

}
