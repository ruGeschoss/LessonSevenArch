//
//  MusicCellModelFactory.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct MusicCellModel {
  let trackName: String
  let collectionName: String?
  let artistName: String?
  let artwork: String?
  let trackTime: String?
}

final class MusicCellModelFactory {
  
  func createMusicCellModel(from model: ITunesSong) -> MusicCellModel {
    let trackTime = convertTrackTimeToString(timeInMillis: model.trackTimeMillis)

    return MusicCellModel(trackName: model.trackName,
                          collectionName: model.collectionName,
                          artistName: model.artistName,
                          artwork: model.artwork,
                          trackTime: trackTime)
  }

  private func convertTrackTimeToString(timeInMillis: Int?) -> String? {
    guard let timeInMillis = timeInMillis else { return nil }
    let timeInSec = timeInMillis / 1000
    let minutes = timeInSec / 60
    let seconds = timeInSec % 60
    let stringMinutes = minutes < 10 ? "0\(minutes)" : "\(minutes)"
    let stringSeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"
    return stringMinutes + ":" + stringSeconds
  }
  
}
