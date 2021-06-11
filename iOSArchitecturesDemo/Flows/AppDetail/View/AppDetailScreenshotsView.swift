//
//  AppDetailScreenshotsView.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 09.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class AppDetailScreenshotsView: UIView {
  
  private(set) lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 100, height: 220)
    layout.scrollDirection = .horizontal
    let collection = UICollectionView(frame: self.frame,
                                      collectionViewLayout: layout)
    collection.backgroundColor = .white
    return collection
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addCollectionView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addCollectionView() {
    addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
}
