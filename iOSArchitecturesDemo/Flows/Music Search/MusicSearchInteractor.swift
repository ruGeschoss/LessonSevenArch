//
//  MusicSearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 15.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol MusicSearchInteractorInterface {
  func getSongs(forQuery: String, completion: @escaping (Result<[ITunesSong], Error>) -> Void)
  func loadImage(url: String?, completion: @escaping (Data?) -> Void)
}

final class MusicSearchInteractor: MusicSearchInteractorInterface {

  private lazy var searchService = ITunesSearchService()
  private lazy var imageLoader = ImageDownloader()
  private let cache = NetworkCache.shared

  func getSongs(forQuery: String, completion: @escaping (Result<[ITunesSong], Error>) -> Void) {
    if let cached = cache.getFromCache(key: forQuery) as? [ITunesSong] {
      completion(.success(cached))
      return
    }

    self.searchService.getSongs(forQuery: forQuery) { [weak self] result in
      guard let self = self else { return }
      result
        .withValue { songs in
          self.cache.saveToCache(key: forQuery, value: songs)
          completion(.success(songs))
        }
        .withError {
          completion(.failure($0))
        }
    }
  }

  func loadImage(url: String?, completion: @escaping (Data?) -> Void) {
    guard let url = url else { return }

    if let cached = cache.getFromCache(key: url) as? Data {
      completion(cached)
      return
    }

    imageLoader.getImage(fromUrl: url) { [weak self] image, _ in
      guard
        let self = self,
        let imageData = image?.pngData()
      else { return }

      self.cache.saveToCache(key: url, value: imageData)
      completion(imageData)
    }
  }

}
