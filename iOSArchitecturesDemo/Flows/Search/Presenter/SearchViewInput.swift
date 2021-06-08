//
//  SearchViewInput.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 08.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol SearchViewInput: AnyObject {
  var searchResults: [ITunesApp] { get set }
  
  func showError(error: Error)
  func showNoResults()
  func hideNoResults()
  func throbber(show: Bool)
}
