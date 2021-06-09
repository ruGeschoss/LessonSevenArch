//
//  AppDetailModel.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 09.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct AppDetailHeaderModel {
  let appName: String
  let company: String?
  let averageRating: String?
  let imageUrl: String?
}

struct AppDetailReleaseInfoModel {
  let releaseVersion: String
  let releaseDate: String?
  let releaseNote: String?
}

final class AppDetailModelFactory {
  
  private let app: ITunesApp
  
  private lazy var initialFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter
  }()
  
  private lazy var outputFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yy"
    return formatter
  }()
  
  init(app: ITunesApp) {
    self.app = app
  }
  
  private func converDateFormat(initial date: String) -> String? {
    guard let initial = initialFormatter.date(from: date) else { return nil }
    return outputFormatter.string(from: initial)
  }
  
  func headerModel() -> AppDetailHeaderModel {
    return AppDetailHeaderModel(appName: app.appName,
                                company: app.company,
                                averageRating: app.averageRating.flatMap { "\($0)" },
                                imageUrl: app.iconUrl)
  }
  
  func releaseInfoModel() -> AppDetailReleaseInfoModel {
    let stringDate = converDateFormat(initial: app.currentVersionReleaseDate)
    return AppDetailReleaseInfoModel(releaseVersion: app.version,
                                     releaseDate: stringDate,
                                     releaseNote: app.releaseNotes)
  }
}
