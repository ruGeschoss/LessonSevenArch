//
//  AppCell.swift
//  iOSArchitecturesDemo
//
//  Created by Evgeny Kireev on 01/03/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

final class AppCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
  
    private(set) lazy var downloadButton: UIButton = {
      let button = UIButton()
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(didTapOnDownload), for: .touchUpInside)
      button.titleLabel?.font = .systemFont(ofSize: 14)
      button.setTitleColor(.black, for: .normal)
      button.setTitle("Download", for: .normal)
      return button
    }()
    
    private(set) lazy var downloadProgressLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .red
      label.font = UIFont.systemFont(ofSize: 12.0)
      return label
    }()
  
    var onDownloadButtonTap: (() -> Void)?
  
    @objc func didTapOnDownload() {
      self.onDownloadButtonTap?()
    }
  
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.subtitleLabel, self.ratingLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addTitleLabel()
        self.addSubtitleLabel()
        self.addRatingLabel()
      self.addDownloadButton()
      self.addDownloadProgressLabel()
    }
    
    private func addTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0)
            ])
    }
    
    private func addSubtitleLabel() {
        self.contentView.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4.0),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0)
            ])
    }
    
    private func addRatingLabel() {
        self.contentView.addSubview(self.ratingLabel)
        NSLayoutConstraint.activate([
            self.ratingLabel.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 4.0),
            self.ratingLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 12.0)
            ])
    }
  
    private func addDownloadButton() {
      self.contentView.addSubview(self.downloadButton)
      NSLayoutConstraint.activate([
        downloadButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
        downloadButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
        downloadButton.leadingAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.trailingAnchor)
      ])
    }
    
    private func addDownloadProgressLabel() {
      self.contentView.addSubview(downloadProgressLabel)
      NSLayoutConstraint.activate([
        downloadProgressLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor),
        downloadProgressLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
        downloadProgressLabel.centerXAnchor.constraint(equalTo: downloadButton.centerXAnchor)
      ])
    }
}
