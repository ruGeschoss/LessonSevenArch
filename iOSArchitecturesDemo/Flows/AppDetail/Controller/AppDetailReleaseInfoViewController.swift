//
//  AppDetailReleaseInfoViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 09.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

final class AppDetailReleaseInfoViewController: UIViewController {
  
  private let model: AppDetailReleaseInfoModel
  
  private var appDetailReleaseInfoView: AppDetailReleaseInfoView {
    return self.view as! AppDetailReleaseInfoView
  }
  
  init(model: AppDetailReleaseInfoModel) {
    self.model = model
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    self.view = AppDetailReleaseInfoView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    appDetailReleaseInfoView.releaseVersion.text = model.releaseVersion
    appDetailReleaseInfoView.releaseDate.text = model.releaseDate
    appDetailReleaseInfoView.releaseNotes.text = model.releaseNote
  }
}
