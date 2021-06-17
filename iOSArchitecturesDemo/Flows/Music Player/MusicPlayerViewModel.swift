//
//  MusicPlayerViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 16.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol MusicPlayerViewModelInterface {
  var trackImage: Observable<UIImage?> { get }
  var trackName: Observable<String?> { get }
  var artistName: Observable<String?> { get }
  var currentPlayTime: Observable<String?> { get }
  var remainingPlayTime: Observable<String?> { get }
  var isPlayingNow: Observable<Bool> { get }

  func prevTrack()
  func nextTrack()
  func playPauseTrack()
  func initialize()
}

final class MusicPlayerViewModel {

  private let downloadService = ImageDownloader()
  private var musicPlayer: MusicPlayerInterface = MusicPlayer()
  
  private let allTracks: [ITunesSong]
  private var currentTrack: ITunesSong {
    didSet {
      initialize()
    }
  }

  var trackImage = Observable<UIImage?>(nil)
  var trackName = Observable<String?>(nil)
  var artistName = Observable<String?>(nil)
  var currentPlayTime = Observable<String?>(nil)
  var remainingPlayTime = Observable<String?>(nil)
  var isPlayingNow: Observable<Bool> = .init(true)

  init(currentTrack: ITunesSong, allTracks: [ITunesSong]) {
    self.currentTrack = currentTrack
    self.allTracks = allTracks

    musicPlayer.currentPlayTime = { [weak self] time in
      self?.currentPlayTime.value = time
    }
    musicPlayer.playTimeLeft = { [weak self] time in
      self?.remainingPlayTime.value = time
    }
    musicPlayer.finishedPlaying = { [weak self] in
      self?.nextTrack()
    }
    musicPlayer.isPlayingNow = { [weak self] isPlaying in
      self?.isPlayingNow.value = isPlaying
    }

  }

  func initialize() {
    trackName.value = currentTrack.trackName
    artistName.value = currentTrack.artistName
    musicPlayer.start(maxTime: currentTrack.trackTimeMillis ?? 0)
    guard let imageUrl = currentTrack.artwork else { return }
    downloadService.getImage(fromUrl: imageUrl) { image, _ in
      self.trackImage.value = image
    }
  }

}

extension MusicPlayerViewModel: MusicPlayerViewModelInterface {

  func prevTrack() {
    let currentIndex = allTracks.firstIndex { $0.trackName == currentTrack.trackName }
    guard let currentIndex = currentIndex, currentIndex > 0 else { return }
    currentTrack = allTracks[currentIndex - 1]
  }

  func nextTrack() {
    let currentIndex = allTracks.firstIndex { $0.trackName == currentTrack.trackName }
    guard let currentIndex = currentIndex, currentIndex < allTracks.count - 1 else { return }
    currentTrack = allTracks[currentIndex + 1]
  }

  func playPauseTrack() {
    musicPlayer.playPause()
  }

}
