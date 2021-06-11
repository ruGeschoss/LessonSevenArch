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
  
  var searchResults = [ITunesApp]() {
    didSet {
      self.searchView.tableView.isHidden = false
      self.searchView.tableView.reloadData()
      self.searchView.searchBar.resignFirstResponder()
    }
  }
  
  private let presenter: SearchViewOutput
  
  init(presenter: SearchViewOutput) {
    self.presenter = presenter
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
  
}

// MARK: - SearchViewInput
extension SearchViewController: SearchViewInput {
  
  func hideNoResults() {
    self.searchView.emptyResultView.isHidden = true
  }
  
  func showNoResults() {
    self.searchView.emptyResultView.isHidden = false
  }
  
  func showError(error: Error) {
    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
    let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(actionOk)
    self.present(alert, animated: true, completion: nil)
  }
  
  func throbber(show: Bool) {
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
    let cellModel = AppCellModelFactory.cellModel(from: app)
    cell.configure(with: cellModel)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let app = searchResults[indexPath.row]
    presenter.viewDidSelectApp(app)
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
    presenter.viewDidSearch(with: query)
  }
}
