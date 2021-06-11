//
//  MusicTableViewCell.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class MusicTableViewCell: UITableViewCell {
  
  private enum Constants {
    static let insets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
  }
  
  private let verticalStack: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    return stackView
  }()
  
  var pictureImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private let trackNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .black
    label.textAlignment = .left
    return label
  }()
  
  private let collectionNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = .lightGray
    label.textAlignment = .left
    return label
  }()
  
  private let artistNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = .black
    label.textAlignment = .left
    return label
  }()
  
  private let trackTimeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()
  
  // MARK: - Base
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    configureUI()
  }
  
  func configure(model: MusicCellModel) {
    trackNameLabel.text = model.trackName
    collectionNameLabel.text = model.collectionName
    artistNameLabel.text = model.artistName
    trackTimeLabel.text = model.trackTime
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    pictureImageView.image = nil
    trackNameLabel.text = nil
    collectionNameLabel.text = nil
    artistNameLabel.text = nil
    trackTimeLabel.text = nil
    
  }
}

// MARK: - UI
extension MusicTableViewCell {
  
  private func configureUI() {
    setupImageView()
    setupTrackLabel()
    setupStackView()
  }
  
  private  func setupImageView() {
    addSubview(pictureImageView)
    
    pictureImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      pictureImageView.widthAnchor.constraint(equalTo: pictureImageView.heightAnchor),
      pictureImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                               constant: Constants.insets.top),
      pictureImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                               constant: -Constants.insets.bottom),
      pictureImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                constant: Constants.insets.left)
    ])
  }
  
  private func setupStackView() {
    verticalStack.addArrangedSubview(trackNameLabel)
    verticalStack.addArrangedSubview(collectionNameLabel)
    verticalStack.addArrangedSubview(artistNameLabel)
    addSubview(verticalStack)
    
    verticalStack.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      verticalStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                         constant: Constants.insets.top),
      verticalStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                            constant: -Constants.insets.bottom),
      verticalStack.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor,
                                             constant: Constants.insets.left),
      verticalStack.trailingAnchor.constraint(equalTo: trackTimeLabel.leadingAnchor,
                                              constant: -Constants.insets.right)
    ])
    
  }
  
  private  func setupTrackLabel() {
    addSubview(trackTimeLabel)
    
    trackTimeLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      trackTimeLabel.widthAnchor.constraint(equalToConstant: 70),
      trackTimeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                          constant: Constants.insets.top),
      trackTimeLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                             constant: -Constants.insets.bottom),
      trackTimeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                               constant: -Constants.insets.right)
    ])
  }
  
}
