//
//  MusicSearchPresenterInterface.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol MusicSearchPresenterInterface {
  func didSelectTrack(track: ITunesSong, allTracks: [ITunesSong])
  func shouldSearchWith(query: String)
  func loadImage(url: String?, completion: @escaping (Data?) -> Void)
}
