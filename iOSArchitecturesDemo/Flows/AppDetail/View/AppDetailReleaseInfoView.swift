//
//  AppDetailReleaseInfoView.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 09.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class AppDetailReleaseInfoView: UIView {
  
  private enum Constants {
    static let releaseInfoTitle = "Что нового?"
    
    static let verticalInset: CGFloat = 10
    static let horizontalInset: CGFloat = 16
    static let largeFontSize: CGFloat = 20
    static let normalFontSize: CGFloat = 13
  }
  
  private lazy var releaseInfoTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: Constants.largeFontSize)
    label.textColor = .black
    label.text = Constants.releaseInfoTitle
    return label
  }()
  
  private(set) lazy var releaseVersion: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: Constants.normalFontSize)
    label.textColor = .lightGray
    label.textAlignment = .left
    return label
  }()
  
  private(set) lazy var releaseDate: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: Constants.normalFontSize)
    label.textColor = .lightGray
    label.textAlignment = .right
    return label
  }()
  
  private(set) lazy var releaseNotes: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: Constants.normalFontSize)
    label.textColor = .black
    label.numberOfLines = 0
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
  }
  
  private func setupUI() {
    addSubview(releaseInfoTitle)
    addSubview(releaseVersion)
    addSubview(releaseDate)
    addSubview(releaseNotes)
    
    releaseInfoTitle.translatesAutoresizingMaskIntoConstraints = false
    releaseVersion.translatesAutoresizingMaskIntoConstraints = false
    releaseDate.translatesAutoresizingMaskIntoConstraints = false
    releaseNotes.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      releaseInfoTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.verticalInset),
      releaseInfoTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                constant: Constants.horizontalInset),
      releaseInfoTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -Constants.horizontalInset),
      
      releaseVersion.topAnchor.constraint(equalTo: releaseInfoTitle.bottomAnchor,
                                          constant: Constants.verticalInset),
      releaseVersion.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                              constant: Constants.horizontalInset),
      
      releaseDate.topAnchor.constraint(equalTo: releaseInfoTitle.bottomAnchor,
                                       constant: Constants.verticalInset),
      releaseDate.leadingAnchor.constraint(equalTo: releaseVersion.trailingAnchor,
                                           constant: Constants.horizontalInset),
      releaseDate.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                            constant: -Constants.horizontalInset),
      
      releaseNotes.topAnchor.constraint(equalTo: releaseVersion.bottomAnchor,
                                        constant: Constants.verticalInset),
      releaseNotes.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                            constant: Constants.horizontalInset),
      releaseNotes.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                             constant: -Constants.horizontalInset),
      releaseNotes.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor,
                                           constant: -Constants.verticalInset)
    ])
  }
  
}
