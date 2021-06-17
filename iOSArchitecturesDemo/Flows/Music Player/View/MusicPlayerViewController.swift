//
//  MusicPlayerViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 16.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//
import UIKit

final class MusicPlayerViewController: UIViewController {

  private var playerView: MusicPlayerView {
    // swiftlint:disable force_cast
    self.view as! MusicPlayerView
    // swiftlint:enable force_cast
  }

  private let viewModel: MusicPlayerViewModelInterface

  init(viewModel: MusicPlayerViewModelInterface) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func loadView() {
    super.loadView()
    self.view = MusicPlayerView()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    bindUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.initialize()
  }

  @objc func nextSong() {
    viewModel.nextTrack()
  }

  @objc func previousSong() {
    viewModel.prevTrack()
  }

  @objc func playPauseSong() {
    viewModel.playPauseTrack()
  }

}

// MARK: - Private
extension MusicPlayerViewController {

  private func bindUI() {
    viewModel.artistName.addObserver(self, closure: { [weak self] artistName, _ in
      self?.playerView.artistName.text = artistName
    })

    viewModel.trackName.addObserver(self, closure: { [weak self] trackName, _ in
      self?.playerView.trackName.text = trackName
    })

    viewModel.currentPlayTime.addObserver(self, closure: { [weak self] currentPlayTime, _ in
      self?.playerView.currentPlayTime.text = currentPlayTime
    })

    viewModel.remainingPlayTime.addObserver(self, closure: { [weak self] remainingPlayTime, _ in
      self?.playerView.remainingPlayTime.text = remainingPlayTime
    })

    viewModel.trackImage.addObserver(self, closure: { [weak self] trackImage, _ in
      self?.playerView.trackImage.image = trackImage
    })

    viewModel.isPlayingNow.addObserver(self) { [weak self] isPlaying, _ in
      self?.playerView.isPlayingNow(isPlaying)
    }
  }

}
