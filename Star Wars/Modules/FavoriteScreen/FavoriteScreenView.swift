//
//  FavoriteScreenView.swift
//  Star Wars
//
//  Created by Raul Rodrigo on 14/08/22.
//

import Foundation
import UIKit
class FavoriteScreenView: UIViewController, ViewInterface {
    let favoriteTableView = UITableView()
    var favoriteCharacters: [StarWarsCharacterResult]?
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
    func onGetFavoriteList(starWarsCharacter: [StarWarsCharacterResult]?) {
        favoriteCharacters = starWarsCharacter
        showLoading(showLoading: false)
        favoriteTableView.reloadData()
    }
    
    func onSaveFavoriteListError() {
        print("error")
    }
}

extension FavoriteScreenView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCharacters?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomeScreenViewTableViewCell
        cell.setup(starData: favoriteCharacters?[indexPath.row])
        return cell
    }
    
    func setupTableView(){
        favoriteTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(favoriteTableView)
        self.view.backgroundColor = .white
        favoriteTableView.tableHeaderView = UIView()
        favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48).isActive = true
        favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48).isActive = true
        favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        favoriteTableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
    }
}

extension FavoriteScreenView {
    func setupNavBar(){
        self.navigationItem.title = "Favorite Screen"
    }
}
