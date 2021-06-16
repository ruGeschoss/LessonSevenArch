//
//  MusicSearchViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Alexander Andrianov on 11.06.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//
// swiftlint:disable force_cast

import UIKit

final class MusicSearchViewController: UIViewController {
  
  private enum Constants {
    static let navigationTitle: String = "Search Music"
  }
  
  let presenter: MusicSearchPresenterInterface
  private lazy var cellModelFactory = MusicCellModelFactory()
  
  var searchResults = [ITunesSong]() {
    didSet {
      self.searchView.tableView.isHidden = false
      self.searchView.tableView.reloadData()
      self.searchView.searchBar.resignFirstResponder()
    }
  }
  
  private var searchView: SearchView {
    return self.view as! SearchView
  }

  init(presenter: MusicSearchPresenterInterface) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    self.view = SearchView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = Constants.navigationTitle
    searchView.searchBar.delegate = self
    searchView.tableView.register(MusicTableViewCell.self,
                                  forCellReuseIdentifier: MusicTableViewCell.reuseID)
    searchView.tableView.delegate = self
    searchView.tableView.dataSource = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    networkActivityIndicator(isOn: false)
  }
}

// MARK: - Interface
extension MusicSearchViewController: MusicSearchControllerInterface {
  
  func showEmptyResult() {
    searchView.emptyResultView.isHidden = false
  }
  
  func hideEmptyResult() {
    searchView.emptyResultView.isHidden = true
  }
  
  func showError(error: Error) {
    let alert = UIAlertController(title: "Error",
                                  message: "\(error.localizedDescription)",
                                  preferredStyle: .alert)
    let actionOk = UIAlertAction(title: "OK",
                                 style: .cancel,
                                 handler: nil)
    alert.addAction(actionOk)
    self.present(alert, animated: true, completion: nil)
  }
  
  func networkActivityIndicator(isOn: Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = isOn
  }
  
}

// MARK: - Table DataSource
extension MusicSearchViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    searchResults.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView
        .dequeueReusableCell(withIdentifier: MusicTableViewCell.reuseID) as? MusicTableViewCell
    else { return UITableViewCell() }
    let song = searchResults[indexPath.row]
    let model = cellModelFactory.createMusicCellModel(from: song)
    presenter.loadImage(url: model.artwork) { data in
      guard let data = data else { return }
      cell.pictureImageView.image = .init(data: data)
    }
    cell.configure(model: model)
    return cell
  }
  
}

// MARK: - Table Delegate
extension MusicSearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    searchView.tableView.deselectRow(at: indexPath, animated: true)
    let selectedTrack = searchResults[indexPath.row]
    presenter.didSelectTrack(track: selectedTrack, allTracks: searchResults)
  }
  
}

// MARK: - Search Delegate
extension MusicSearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let query = searchBar.text else {
      searchBar.resignFirstResponder()
      return
    }
    if query.count == .zero {
      searchBar.resignFirstResponder()
      return
    }
    presenter.shouldSearchWith(query: query)
  }
  
}
