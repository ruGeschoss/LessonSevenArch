//
//  AppDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 08.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

final class AppDetailHeaderViewController: UIViewController {
  
  // MARK: - Properties
  
  private let model: AppDetailHeaderModel
  
  private let imageDownloader = ImageDownloader()
  
  private var appDetailHeaderView: AppDetailHeaderView {
    return self.view as! AppDetailHeaderView
  }
  
  // MARK: - Init
  init(model: AppDetailHeaderModel) {
    self.model = model
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func loadView() {
    super.loadView()
    self.view = AppDetailHeaderView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.fillData()
  }
  
  // MARK: - Private
  private func fillData() {
    self.downloadImage()
    self.appDetailHeaderView.titleLabel.text = model.appName
    self.appDetailHeaderView.subtitleLabel.text = model.company
    self.appDetailHeaderView.ratingLabel.text = model.averageRating
  }
  
  private func downloadImage() {
    guard let url = self.model.imageUrl else { return }
    self.imageDownloader.getImage(fromUrl: url) { [weak self] (image, _) in
      self?.appDetailHeaderView.imageView.image = image
    }
  }
}
