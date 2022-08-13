//
//  HomeScreenView.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 10/07/22.
//

import UIKit

class HomeScreenView: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewInterface {
    var presenter: ViewToPresenterHomeScreenProtocol?
    var label: String?
    var identifier = "Cell reuse identifier"
    var starData: StarWarsCharacter?
    var characters: [StarWarsCharacterResult]?
    var filterCharacters: [StarWarsCharacterResult]?
    var indexNext: String?
    
    
    @IBOutlet weak var characterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        presenter?.viewDidLoad(path: nil)
        showLoading(showLoading: true)
        characterListTableView.prefetchDataSource = self
        characterListTableView.delegate = self
        characterListTableView.dataSource = self
        characterListTableView.register(HomeScreenViewTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    func tableView(_ characterListTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterCharacters == nil  {
            return characters?.count ?? 1
        } else if ((filterCharacters ?? []).isEmpty) && !(self.navigationItem.searchController?.searchBar.text ?? "").isEmpty {
            return 0
        }else if ((filterCharacters ?? []).isEmpty) && self.navigationItem.searchController?.searchBar.text != nil{
            return characters?.count ?? 1
        } else {
            return filterCharacters?.count ?? 1
        }
    }
    
    func tableView(_ characterListTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = characterListTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomeScreenViewTableViewCell
        if filterCharacters == nil  {
            cell.setup(starData: characters?[indexPath.row])
        } else if ((filterCharacters ?? []).isEmpty) && !(self.navigationItem.searchController?.searchBar.text ?? "").isEmpty {
            cell.setup(starData: nil)
        }else if ((filterCharacters ?? []).isEmpty) && self.navigationItem.searchController?.searchBar.text != nil{
            cell.setup(starData: characters?[indexPath.row])
        } else {
            cell.setup(starData: filterCharacters?[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(filterCharacters != nil && (filterCharacters ?? []).isEmpty) {
            presenter?.router?.pushToDetailScreen(on: self, starWarsCharacterResult: filterCharacters![indexPath.row])
        } else {
            presenter?.router?.pushToDetailScreen(on: self, starWarsCharacterResult: characters![indexPath.row])
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeScreenView: PresenterToViewHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter) {
        self.starData = starWarsCharacter
        if characters == nil {
            self.characters = starWarsCharacter.results
        } else {
            self.characters! += starWarsCharacter.results
        }
        showLoading(showLoading: false)
        self.characterListTableView.reloadData()
        
    }
    
    func onGetCharacterListError() {
    }
}

extension HomeScreenView: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexNext != starData?.next && starData?.next != nil {
            presenter?.viewDidLoad(path: starData?.next)
            indexNext = starData?.next
        }
    }
}

extension HomeScreenView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterCharacters = characters?.filter{(filterCharacter) -> Bool in filterCharacter.name!.contains(searchController.searchBar.text!)}
        self.characterListTableView.reloadData()
    }
    
    func setupTabBar(){
        
        self.navigationItem.title = "Home Screen"
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}



