//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

final class SearchViewController: UIViewController {
  
  private enum Constants {
    static let navigationTitle: String = "Search via iTunes"
  }
  
  // MARK: - Private Properties
  private var searchView: SearchView {
    return self.view as! SearchView
  }
  
  var searchResults = [SearchAppCellModel]() {
    didSet {
      self.searchView.tableView.isHidden = false
      self.searchView.tableView.reloadData()
      self.searchView.searchBar.resignFirstResponder()
    }
  }
  
  private let viewModel: SearchViewModel
  
  init(viewModel: SearchViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle
  override func loadView() {
    super.loadView()
    self.view = SearchView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModel()
    
    self.navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = Constants.navigationTitle
    self.searchView.searchBar.delegate = self
    self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: AppCell.reuseID)
    self.searchView.tableView.delegate = self
    self.searchView.tableView.dataSource = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.throbber(show: false)
  }
  
  private func bindViewModel() {
    self.viewModel.isLoading.addObserver(self) { [weak self] (isLoading, _) in
      self?.throbber(show: isLoading)
    }
    self.viewModel.error.addObserver(self) { [weak self] (error, _) in
      if let error = error {
        self?.showError(error: error)
      }
    }
    self.viewModel.showEmptyResults.addObserver(self) { [weak self] (showEmptyResults, _) in
      self?.searchView.emptyResultView.isHidden = !showEmptyResults
      self?.searchView.tableView.isHidden = showEmptyResults
    }
    self.viewModel.cellModels.addObserver(self) { [weak self] (searchResults, _) in
      self?.searchResults = searchResults
    }
  }
  
}

// MARK: - SearchViewInput
extension SearchViewController {
  
  private func showError(error: Error) {
    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
    let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(actionOk)
    self.present(alert, animated: true, completion: nil)
  }
  
  private func throbber(show: Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = show
  }
  
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchResults.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: AppCell.reuseID, for: indexPath)
    guard let cell = dequeuedCell as? AppCell else {
      return dequeuedCell
    }
    let app = self.searchResults[indexPath.row]
    configure(cell: cell, with: app)
    return cell
  }
  
  private func configure(cell: AppCell, with app: SearchAppCellModel) {
    cell.onDownloadButtonTap = { [weak self] in
      self?.viewModel.didTapDownloadApp(app)
    }
    cell.titleLabel.text = app.appName
    cell.subtitleLabel.text = app.company
    cell.ratingLabel.text = app.averageRating >>- { "\($0)" }
    
    switch app.downloadState {
    case .notStarted:
      cell.downloadProgressLabel.text = nil
    case .inProgress(let progress):
      let progressToShow = round(progress * 100.0) / 100.0
      cell.downloadProgressLabel.text = "\(progressToShow)"
    case .downloaded:
      cell.downloadProgressLabel.text = "Загружено"
    }
  }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let model = searchResults[indexPath.row]
    viewModel.didSelectApp(model)
  }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let query = searchBar.text else {
      searchBar.resignFirstResponder()
      return
    }
    if query.count == 0 {
      searchBar.resignFirstResponder()
      return
    }
    viewModel.search(for: query)
  }
}
