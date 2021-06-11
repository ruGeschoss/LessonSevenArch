//
//  +TableViewCell.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol AccessibleTableCell {}

extension UITableViewCell: AccessibleTableCell {}

extension AccessibleTableCell where Self: UITableViewCell {
  static var reuseID: String {
    String(describing: self)
  }
}
