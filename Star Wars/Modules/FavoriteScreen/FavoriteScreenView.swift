//
//  FavoriteScreenView.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 14/08/22.
//

import Foundation
import UIKit
class FavoriteScreenView: UIViewController, ViewInterface {
    lazy private var favoriteTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableHeaderView = UIView()
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: ViewToPresenterFavoriteScreenProtocol?
    let identifier = "Cell reuse identifier"
    override func viewDidLoad() {
        setupNavBar()
        showLoading(showLoading: true)
        setupTableView()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
        favoriteTableView.register(HomeScreenViewTableViewCell.self, forCellReuseIdentifier: identifier)
        presenter?.getFavorites()
    }
}

extension FavoriteScreenView: PresenterToViewFavoriteScreenProtocol {
    func reloadData() {
        favoriteTableView.reloadData()
    }
    
    func saveFavoriteListError() {
        print("error on fav")
    }
}

extension FavoriteScreenView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.favoriteTableViewCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoriteTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? HomeScreenViewTableViewCell else {return UITableViewCell()}
        guard let favoriteCharacters = presenter?.favoriteCharactersOnView() else {return UITableViewCell()}
        cell.setup(starData: favoriteCharacters[indexPath.row], index: indexPath.row, isCharacterFavorite: true)
        cell.delegate = self
        return cell
    }
}

extension FavoriteScreenView {
    func setupNavBar(){
        self.navigationItem.title = "Favorite Screen"
    }
    func setupTableView(){
        self.view.addSubview(favoriteTableView)
        self.view.backgroundColor = .white
        favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
        favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension FavoriteScreenView: favoriteCellProtocol {
    func onFavoritePress(index: Int) {
        presenter?.onPressToFavorite(index: index)
        }
    }

