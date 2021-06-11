//
//  MusicSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class MusicSearchPresenter {
  
  weak var controller: (UIViewController & MusicSearchControllerInterface)?
  
  private lazy var searchService = ITunesSearchService()
  private lazy var imageLoader = ImageDownloader()
  
  private func requestSongs(with query: String) {
    self.searchService.getSongs(forQuery: query) { [weak self] result in
      guard let self = self else { return }
      self.controller?.networkActivityIndicator(isOn: false)
      result
        .withValue { songs in
          guard !songs.isEmpty else {
            self.controller?.showEmptyResult()
            return
          }
          self.controller?.searchResults = songs
          self.controller?.hideEmptyResult()
        }
        .withError {
          self.controller?.showError(error: $0)
        }
    }
  }
  
}

extension MusicSearchPresenter: MusicSearchPresenterInterface {
  
  func didSelectTrack(track: ITunesSong) {
    print("Did select \(track.trackName)")
  }
  
  func shouldSearchWith(query: String) {
    controller?.networkActivityIndicator(isOn: true)
    requestSongs(with: query)
  }
  
  func loadImage(url: String?, completion: @escaping (Data?) -> Void) {
    guard let url = url else { return }
    imageLoader.getImage(fromUrl: url) { image, _ in
      guard let image = image else { return }
      completion(image.pngData())
    }
  }
  
}
