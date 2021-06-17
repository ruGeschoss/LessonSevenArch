//
//  MusicPlayerView.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 16.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class MusicPlayerView: UIView {

  // MARK: - Properties
  lazy var trackImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .clear
    return imageView
  }()
  lazy var trackName: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  lazy var artistName: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 15)
    return label
  }()

  // TODO: StatusView UIView + Bezier?
  private lazy var playStatus: UIView = {
    let view = UIView()
    view.backgroundColor = .systemPink
    return view
  }()
  lazy var currentPlayTime: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .systemFont(ofSize: 12)
    return label
  }()
  lazy var remainingPlayTime: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.font = .systemFont(ofSize: 12)
    return label
  }()

  private lazy var previousSongButton: UIButton = {
    let button = UIButton()
    button.setTitle("Prev", for: .normal)
    button.setTitleColor(.red, for: .normal)
    button.tintColor = .red
    button.addTarget(nil,
                     action: #selector(MusicPlayerViewController.previousSong),
                     for: .touchUpInside)
    return button
  }()
  private lazy var playPauseSongButton: UIButton = {
    let button = UIButton()
    button.setTitleColor(.red, for: .normal)
    button.tintColor = .red
    button.addTarget(nil,
                     action: #selector(MusicPlayerViewController.playPauseSong),
                     for: .touchUpInside)
    return button
  }()
  private lazy var nextSongButton: UIButton = {
    let button = UIButton()
    button.setTitle("Next", for: .normal)
    button.setTitleColor(.red, for: .normal)
    button.tintColor = .red
    button.addTarget(nil,
                     action: #selector(MusicPlayerViewController.nextSong),
                     for: .touchUpInside)
    return button
  }()
  private lazy var buttonsStack: UIStackView = {
    let stack = UIStackView()
    stack.distribution = .fillProportionally
    stack.axis = .horizontal
    stack.addArrangedSubview(previousSongButton)
    stack.addArrangedSubview(playPauseSongButton)
    stack.addArrangedSubview(nextSongButton)
    return stack
  }()

  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    backgroundColor = .white
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func isPlayingNow(_ isPlaying: Bool) {
    let title = !isPlaying ? "Play" : "Pause"
    playPauseSongButton.setTitle(title, for: .normal)
  }

  // MARK: - SetupUI
  private func configureUI() {
    addButtonsStack()
    addCurrentPlayTimeLabel()
    addRemainingPlayTimeLabel()
    addPlayStatusView()
    addArtistNameLabel()
    addTrackNameLabel()
    addTrackImage()
  }

  private func addButtonsStack() {
    addSubview(buttonsStack)
    buttonsStack.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      buttonsStack.heightAnchor.constraint(equalToConstant: 60),
      buttonsStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
      buttonsStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
      buttonsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15)
    ])
  }

  private func addCurrentPlayTimeLabel() {
    addSubview(currentPlayTime)
    currentPlayTime.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      currentPlayTime.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
      currentPlayTime.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -10)
    ])
  }

  private func addRemainingPlayTimeLabel() {
    addSubview(remainingPlayTime)
    remainingPlayTime.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      remainingPlayTime.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      remainingPlayTime.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -10)
    ])
  }

  private func addPlayStatusView() {
    addSubview(playStatus)
    playStatus.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      playStatus.bottomAnchor.constraint(equalTo: currentPlayTime.topAnchor, constant: -10),
      playStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
      playStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
      playStatus.heightAnchor.constraint(equalToConstant: 10)
    ])
  }

  private func addArtistNameLabel() {
    addSubview(artistName)
    artistName.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      artistName.bottomAnchor.constraint(equalTo: playStatus.topAnchor, constant: -10),
      artistName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
      artistName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40)
    ])
  }

  private func addTrackNameLabel() {
    addSubview(trackName)
    trackName.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      trackName.bottomAnchor.constraint(equalTo: artistName.topAnchor),
      trackName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
      trackName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40)
    ])
  }

  private func addTrackImage() {
    addSubview(trackImage)
    trackImage.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      trackImage.bottomAnchor.constraint(equalTo: trackName.topAnchor, constant: -10),
      trackImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
      trackImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
      trackImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50)
    ])
  }
}
