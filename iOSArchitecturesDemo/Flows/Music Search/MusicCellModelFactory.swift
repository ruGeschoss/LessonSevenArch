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
  
  private lazy var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "mm:ss"
    return formatter
  }()
  
  private var timeCache: [Int: String] = [:]
  
  func createMusicCellModel(from model: ITunesSong) -> MusicCellModel {
    let trackTime = getTrackTime(millisec: model.trackTimeMillis)
    
    return MusicCellModel(trackName: model.trackName,
                          collectionName: model.collectionName,
                          artistName: model.artistName,
                          artwork: model.artwork,
                          trackTime: trackTime)
  }
  
  private func getTrackTime(millisec: Int?) -> String? {
    guard let time = millisec else { return nil }
    
    if let storedTime = timeCache[time] {
      return storedTime
    } else {
      let timeInSeconds = Double(time) / 1000
      let dateFromSecond = Date(timeIntervalSince1970: timeInSeconds)
      let trackTime = formatter.string(from: dateFromSecond)
      timeCache[time] = trackTime
      return trackTime
    }
  }
  
}
