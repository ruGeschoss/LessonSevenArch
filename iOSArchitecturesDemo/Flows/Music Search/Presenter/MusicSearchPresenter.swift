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
  private let interactor: MusicSearchInteractorInterface
  private let router: MusicSearchRouterInterface

  init(interactor: MusicSearchInteractorInterface, router: MusicSearchRouterInterface) {
    self.interactor = interactor
    self.router = router
  }
  
  private func requestSongs(with query: String) {
    interactor.getSongs(forQuery: query) { [weak self] result in
      guard let self = self else { return }
      self.controller?.networkActivityIndicator(isOn: false)
      switch result {
      case let .success(songs):
        guard !songs.isEmpty else {
          self.controller?.showEmptyResult()
          return
        }
        self.controller?.searchResults = songs
        self.controller?.hideEmptyResult()
      case let .failure(error):
        self.controller?.showError(error: error)
      }
    }
  }

  private func getImageFromUrl(url: String?, completion: @escaping (Data?) -> Void) {
    interactor.loadImage(url: url, completion: completion)
  }
  
}

extension MusicSearchPresenter: MusicSearchPresenterInterface {
  
  func didSelectTrack(track: ITunesSong) {
    router.pushMusicPlayer()
  }
  
  func shouldSearchWith(query: String) {
    controller?.networkActivityIndicator(isOn: true)
    requestSongs(with: query)
  }
  
  func loadImage(url: String?, completion: @escaping (Data?) -> Void) {
    getImageFromUrl(url: url, completion: completion)
  }
  
}
