//
//  AppDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 20.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class AppDetailViewController: UIViewController {
  
  let app: ITunesApp
  lazy var factory = AppDetailModelFactory(app: app)
  
  lazy var headerViewController = AppDetailHeaderViewController(model: factory.headerModel())
  lazy var releaseInfoViewController = AppDetailReleaseInfoViewController(model: factory.releaseInfoModel())
  
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
  
  private func configureUI() {
    self.view.backgroundColor = .white
    self.navigationController?.navigationBar.tintColor = UIColor.white
    self.navigationItem.largeTitleDisplayMode = .never
    self.addHeaderViewController()
    self.addDescriptionViewController()
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
  
  private func addDescriptionViewController() {
    self.addChild(releaseInfoViewController)
    self.view.addSubview(releaseInfoViewController.view)
    releaseInfoViewController.didMove(toParent: self)
    
    releaseInfoViewController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      releaseInfoViewController.view.topAnchor.constraint(equalTo: self.headerViewController.view.bottomAnchor),
      releaseInfoViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      releaseInfoViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
//      releaseInfoViewController.view.heightAnchor.constraint(equalToConstant: 250.0)
    ])
  }
}
