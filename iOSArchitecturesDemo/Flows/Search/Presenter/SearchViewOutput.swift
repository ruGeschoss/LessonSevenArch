//
//  SearchViewOutput.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 08.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

protocol SearchViewOutput: AnyObject {
  func viewDidSearch(with query: String)
  func viewDidSelectApp(_ app: ITunesApp)
}
