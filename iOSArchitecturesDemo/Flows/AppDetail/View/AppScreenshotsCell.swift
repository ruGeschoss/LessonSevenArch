//
//  AppScreenshotsCell.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 09.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class AppScreenshotsCell: UICollectionViewCell {
  
  private let screenshotImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addScreenshotImageView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setImage(image: UIImage) {
    screenshotImageView.image = image
  }
  
  private func addScreenshotImageView() {
    addSubview(screenshotImageView)
    screenshotImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      screenshotImageView.topAnchor.constraint(equalTo: topAnchor),
      screenshotImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      screenshotImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      screenshotImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
}
