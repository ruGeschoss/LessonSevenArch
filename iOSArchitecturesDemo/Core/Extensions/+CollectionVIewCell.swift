//
//  +CollectionVIewCell.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol AccessibleCollectionCell {}

extension UICollectionViewCell: AccessibleCollectionCell {}

extension AccessibleCollectionCell where Self: UICollectionViewCell {
  static var reuseID: String {
    String(describing: self)
  }
}
