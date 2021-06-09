//
//  AppDetailScreenshotsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 09.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

final class AppDetailScreenshotsViewController: UIViewController {
  
  private let model: AppDetailScreenshotsModel
  var selectedIndex: Int = 0
  
  private var appDetailScreenshotsView: AppDetailScreenshotsView {
    return self.view as! AppDetailScreenshotsView
  }
  
  init(model: AppDetailScreenshotsModel) {
    self.model = model
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    self.view = AppDetailScreenshotsView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    appDetailScreenshotsView.collectionView.delegate = self
    appDetailScreenshotsView.collectionView.dataSource = self
    appDetailScreenshotsView.collectionView
      .register(AppScreenshotsCell.self, forCellWithReuseIdentifier: "AppScreenshotsCell")
  }
  
}

extension AppDetailScreenshotsViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView,
                      didSelectItemAt indexPath: IndexPath) {
    selectedIndex = indexPath.item
    UIApplication.shared
      .sendAction(#selector(AppDetailViewController.didTapOnScreenshot(sender:)),
                  to: nil,
                  from: self,
                  for: nil)
  }
  
}

extension AppDetailScreenshotsViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    model.screenshots.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppScreenshotsCell",
                                                  for: indexPath)
    guard let screenshotCell = cell as? AppScreenshotsCell else { return cell }
    ImageDownloader().getImage(fromUrl: model.screenshots[indexPath.row]) { (image, _) in
      guard let image = image else { return }
      DispatchQueue.main.async {
        screenshotCell.setImage(image: image)
      }
    }
    return screenshotCell
  }
  
}
