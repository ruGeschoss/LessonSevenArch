//
//  MusicPlayer.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 16.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol MusicPlayerInterface {
  var currentPlayTime: ((String) -> Void)? { get set }
  var playTimeLeft: ((String) -> Void)? { get set }
  var finishedPlaying: (() -> Void)? { get set }
  var isPlayingNow: ((Bool) -> Void)? { get set }
  func start(maxTime: Int)
  func playPause()
}

final class MusicPlayer: MusicPlayerInterface {

  private enum Constants {
    static let updateRate: Double = 0.5
    static var timeStep: Int {
      Int(updateRate * 1000)
    }
  }

  private enum MusicPlayerState {
    case playing(currentTime: Int)
    case paused
  }

  private var timer: Timer?
  private var currentPlayerState: MusicPlayerState = .paused
  private var currentTimeStep: Int = .zero
  private var timeCache: [Int: String] = [:]
  private var isPlaying = false {
    didSet {
      isPlayingNow?(isPlaying)
    }
  }

  var currentPlayTime: ((String) -> Void)?
  var playTimeLeft: ((String) -> Void)?
  var finishedPlaying: (() -> Void)?
  var isPlayingNow: ((Bool) -> Void)?

  func start(maxTime: Int) {
    resetTimer()
    setTimer(withLimit: maxTime)
    RunLoop.main.add(timer!, forMode: .common)
  }

  func playPause() {
    isPlaying ? pause() : play()
  }

}

// MARK: - Private functions
extension MusicPlayer {

  private func setTimer(withLimit maxTime: Int) {
    timer = Timer.scheduledTimer(withTimeInterval: Constants.updateRate, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      switch self.currentPlayerState {
      case let .playing(currentTime: currentTime):
        let nextTimeStep = currentTime + Constants.timeStep
        if nextTimeStep <= maxTime {
          self.currentTimeStep = nextTimeStep
          self.currentPlayerState = .playing(currentTime: nextTimeStep)
        } else {
          self.resetTimer()
          self.finishedPlaying?()
        }
      default:
        break
      }
      let currentTime = self.converTimeToString(time: self.currentTimeStep)
      let timeLeft = self.converTimeToString(time: maxTime - self.currentTimeStep)
      self.currentPlayTime?(currentTime)
      self.playTimeLeft?("-" + timeLeft)
    }
  }

  private func resetTimer() {
    timer?.invalidate()
    isPlaying = true
    currentPlayerState = .playing(currentTime: .zero)
  }

  private func play() {
    isPlaying = true
    currentPlayerState = .playing(currentTime: currentTimeStep)
  }

  private func pause() {
    isPlaying = false
    currentPlayerState = .paused
  }

  private func converTimeToString(time: Int) -> String {
    let timeInSeconds = time / 1000

    if let cachedTime = timeCache[timeInSeconds] {
      return cachedTime
    }

    let seconds = timeInSeconds % 60
    let minutes = timeInSeconds / 60
    let stringSeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"
    let stringMinutes = minutes < 10 ? "0\(minutes)" : "\(minutes)"

    let convertedTime = stringMinutes + ":" + stringSeconds
    timeCache[timeInSeconds] = convertedTime

    return convertedTime
  }

}
