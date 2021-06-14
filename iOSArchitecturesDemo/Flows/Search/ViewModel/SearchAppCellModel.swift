//
//  SearchAppCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 14.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct SearchAppCellModel {
  let appName: String
  let company: String?
  let averageRating: Float?
  let downloadState: DownloadingApp.DownloadState
}
