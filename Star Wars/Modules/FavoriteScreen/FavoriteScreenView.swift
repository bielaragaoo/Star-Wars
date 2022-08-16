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
        view.addSubview(favoriteTableView)
        favoriteTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        favoriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        favoriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        favoriteTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}

extension FavoriteScreenView {
    func setupNavBar(){
        self.navigationItem.title = "Favorite Screen"
    }
}
