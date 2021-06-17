//
//  MusicSearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 15.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol MusicSearchRouterInterface {
  func pushMusicPlayer(withTrack: ITunesSong, allTracks: [ITunesSong])
}

final class MusicSearchRouter: MusicSearchRouterInterface {

  weak var controller: UIViewController?

  func pushMusicPlayer(withTrack: ITunesSong, allTracks: [ITunesSong]) {
    let musicVC = MusicPlayerBuilder.build(currentTrack: withTrack, allTracks: allTracks)
    controller?.present(musicVC, animated: true)
  }

}
