//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
  
  private let app: ITunesApp
  private lazy var factory = AppDetailModelFactory(app: app)
  
  private lazy var headerViewController = AppDetailHeaderViewController(
    model: factory.headerModel())
  private lazy var screenshotsViewController = AppDetailScreenshotsViewController(
    model: factory.screenshotModel())
  private lazy var releaseInfoViewController = AppDetailReleaseInfoViewController(
    model: factory.releaseInfoModel())
  
  init(app: ITunesApp) {
    self.app = app
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureUI()
  }
  
  @objc func didTapOnScreenshot(sender: Any?) {
    let indexToPresent = screenshotsViewController.selectedIndex
    let fullScreenVC = AppDetailFullScreenshotsViewController(
      model: factory.screenshotModel(), indexToStart: indexToPresent)
    present(fullScreenVC, animated: true)
  }
  
  private func configureUI() {
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationItem.largeTitleDisplayMode = .never
    self.addHeaderViewController()
    self.addScreenshotsViewController()
    self.addReleaseInfoViewController()
  }
  
  private func addHeaderViewController() {
    self.addChild(self.headerViewController)
    self.view.addSubview(self.headerViewController.view)
    self.headerViewController.didMove(toParent: self)
    
    self.headerViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.headerViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.headerViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.headerViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
    ])
  }
  
  private func addScreenshotsViewController() {
    self.addChild(self.screenshotsViewController)
    self.view.addSubview(self.screenshotsViewController.view)
    self.screenshotsViewController.didMove(toParent: self)
    
    self.screenshotsViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.screenshotsViewController.view.topAnchor.constraint(equalTo: headerViewController.view.bottomAnchor),
      self.screenshotsViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.screenshotsViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.screenshotsViewController.view.heightAnchor.constraint(equalToConstant: 230)
    ])
  }
  
  private func addReleaseInfoViewController() {
    self.addChild(releaseInfoViewController)
    self.view.addSubview(releaseInfoViewController.view)
    releaseInfoViewController.didMove(toParent: self)
    
    releaseInfoViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      releaseInfoViewController.view.topAnchor.constraint(equalTo: self.screenshotsViewController.view.bottomAnchor),
      releaseInfoViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      releaseInfoViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
    ])
  }
}
