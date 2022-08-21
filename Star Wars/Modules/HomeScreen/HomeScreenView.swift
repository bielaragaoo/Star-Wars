//
//  HomeScreenView.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 10/07/22.
//

import UIKit

class HomeScreenView: UIViewController {
    var presenter: ViewToPresenterHomeScreenProtocol!
    var identifier = "Cell reuse identifier"
    
    @IBOutlet weak var characterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        presenter.viewDidLoad(path: nil)
        characterListTableView.prefetchDataSource = self
        characterListTableView.delegate = self
        characterListTableView.dataSource = self
        characterListTableView.register(HomeScreenViewTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(false)
        presenter.updateInfo()
    }
}

extension HomeScreenView: PresenterToViewHomeScreenProtocol {
    func showLoadingPage(show: Bool) {
        showLoading(showLoading: show)
    }
    
    func reloadData() {
        characterListTableView.reloadData()
    }
}

extension HomeScreenView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        presenter.prefetchStarWarsData()
    }
}

extension HomeScreenView:  UITableViewDelegate, UITableViewDataSource{
    func tableView(_ characterListTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tableViewCount()
    }
    
    func tableView(_ characterListTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = characterListTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? HomeScreenViewTableViewCell else {return UITableViewCell()}
        let charactersInfo = presenter.charactersInfo()
        cell.setup(starData: charactersInfo[indexPath.row], index: indexPath.row, isCharacterFavorite: presenter.isFavoriteCharacter(index: indexPath.row))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.goToDetailScreen(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeScreenView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.searchCharacters(for: searchController.searchBar.text)
    }
}

extension HomeScreenView: favoriteCellProtocol{
    func onFavoritePress(index: Int) {
        presenter.favoriteCharacter(index: index)
    }
}

extension HomeScreenView{
    func setupTabBar(){
        self.navigationItem.title = "Home Screen"
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        let favoriteIcon = UIImage(named: "fav-icon.png")?.withTintColor(UIColor.red).withRenderingMode(.alwaysOriginal) ?? UIImage()
        let favItem = UIBarButtonItem(image: favoriteIcon, style: .plain, target: self, action: #selector(goToFav))
        self.navigationItem.setRightBarButton(favItem, animated: false)
    }
    @objc func goToFav() {
        presenter?.goToFavoriteScreen()
    }
}



