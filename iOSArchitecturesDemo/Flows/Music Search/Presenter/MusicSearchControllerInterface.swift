//
//  MusicSearchControllerInterface.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol MusicSearchControllerInterface {
  var searchResults: [ITunesSong] { get set }
  
  func showEmptyResult()
  func hideEmptyResult()
  func showError(error: Error)
  func networkActivityIndicator(isOn: Bool)
}
