//
//  AppDetailFullScreenshotsViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 10.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class AppDetailFullScreenshotsViewController: UIViewController {
  
  private lazy var pageController: UIPageViewController = {
    let pageVC = UIPageViewController(transitionStyle: .scroll,
                                      navigationOrientation: .horizontal,
                                      options: nil)
    return pageVC
  }()
  
  private let model: AppDetailScreenshotsModel
  private var currentIndex: Int
  
  init(model: AppDetailScreenshotsModel, indexToStart: Int) {
    self.model = model
    self.currentIndex = indexToStart
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pageController.dataSource = self
    addPageController()
  }
  
  private func addPageController() {
    self.addChild(self.pageController)
    self.view.addSubview(self.pageController.view)
    self.pageController.didMove(toParent: self)
    self.pageController.view.backgroundColor = .clear
    
    let imageUrl = model.screenshots[currentIndex]
    pageController.setViewControllers([AppDetailSingleScreenshotViewController(screenshotUrl: imageUrl)],
                                      direction: .forward,
                                      animated: true)
    
    self.pageController.view.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      self.pageController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      self.pageController.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      self.pageController.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      self.pageController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
}

extension AppDetailFullScreenshotsViewController: UIPageViewControllerDataSource {
  
  func presentationCount(for pageViewController: UIPageViewController) -> Int {
    model.screenshots.count
  }
  
  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    currentIndex
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard currentIndex > .zero else { return nil }
    currentIndex -= 1
    let imageUrl = model.screenshots[currentIndex]
    let pageVC = AppDetailSingleScreenshotViewController(screenshotUrl: imageUrl)
    return pageVC
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard currentIndex < model.screenshots.count - 1 else { return nil }
    currentIndex += 1
    let imageUrl = model.screenshots[currentIndex]
    let pageVC = AppDetailSingleScreenshotViewController(screenshotUrl: imageUrl)
    return pageVC
  }
}
