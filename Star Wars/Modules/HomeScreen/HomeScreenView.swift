//
//  HomeScreenView.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 10/07/22.
//

import UIKit

class HomeScreenView: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewInterface {
    var presenter: ViewToPresenterHomeScreenProtocol?
    var favoritePresenter: ViewToPresenterFavoriteScreenProtocol?
    var label: String?
    var identifier = "Cell reuse identifier"
    var starData: StarWarsCharacter?
    var characters: [StarWarsCharacterResult]?
    var favoriteCharacters: [StarWarsCharacterResult]?
    var filterCharacters: [StarWarsCharacterResult]?
    var indexNext: String?
    
    
    @IBOutlet weak var characterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        presenter?.viewDidLoad(path: nil)
        favoritePresenter?.getFavorites()
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
            cell.setup(starData: characters?[indexPath.row], index: indexPath.row, isCharacterFavorite: (favoriteCharacters != nil && favoriteCharacters!.contains(where: { character in
                character.name == (!(filterCharacters ?? []).isEmpty ? filterCharacters?[indexPath.row].name : characters?[indexPath.row].name)
            })))
        } else if ((filterCharacters ?? []).isEmpty) && !(self.navigationItem.searchController?.searchBar.text ?? "").isEmpty {
            cell.setup(starData: nil,index: indexPath.row, isCharacterFavorite: (favoriteCharacters != nil && favoriteCharacters!.contains(where: { character in
                character.name == (!(filterCharacters ?? []).isEmpty ? filterCharacters?[indexPath.row].name : characters?[indexPath.row].name)
            })))
        }else if ((filterCharacters ?? []).isEmpty) && self.navigationItem.searchController?.searchBar.text != nil{
            cell.setup(starData: characters?[indexPath.row], index: indexPath.row, isCharacterFavorite: (favoriteCharacters != nil && favoriteCharacters!.contains(where: { character in
                character.name == (!(filterCharacters ?? []).isEmpty ? filterCharacters?[indexPath.row].name : characters?[indexPath.row].name)
            })))
        } else {
            cell.setup(starData: filterCharacters?[indexPath.row], index: indexPath.row, isCharacterFavorite: (favoriteCharacters != nil && favoriteCharacters!.contains(where: { character in
                character.name == (!(filterCharacters ?? []).isEmpty ? filterCharacters?[indexPath.row].name : characters?[indexPath.row].name)
            })))
        }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(filterCharacters != nil && !(filterCharacters ?? []).isEmpty) {
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
        let favoriteIcon = UIImage(named: "fav-icon.png")?.withTintColor(UIColor.red).withRenderingMode(.alwaysOriginal) ?? UIImage()
        let favItem = UIBarButtonItem(image: favoriteIcon, style: .plain, target: self, action: #selector(goToFav))
        self.navigationItem.setRightBarButton(favItem, animated: false)
    }
    @objc func goToFav() { // remove @objc for Swift 3
        presenter?.router?.pushToFavoriteScreen(on: self)
    }
}

extension HomeScreenView: favoriteCellProtocol{
    func onFavoritePress(index: Int) {
        if(favoriteCharacters != nil && favoriteCharacters!.contains(where: { character in
            character.name == (!(filterCharacters ?? []).isEmpty ? filterCharacters?[index].name : characters![index].name)
        })){
            favoriteCharacters?.removeAll(where: { character in
                character.name == (!(filterCharacters ?? []).isEmpty ? filterCharacters?[index].name : characters![index].name)
            })
            favoritePresenter?.saveFavorites(starWarsCharacter:favoriteCharacters ??  [] )
            self.characterListTableView.reloadData()
        } else {
            favoriteCharacters?.append((!(filterCharacters ?? []).isEmpty ? filterCharacters![index] : characters![index]))
            favoritePresenter?.saveFavorites(starWarsCharacter: favoriteCharacters!)
            self.characterListTableView.reloadData()
        }
    }
}
extension HomeScreenView: PresenterToViewFavoriteScreenProtocol{
    func onGetFavoriteList(starWarsCharacter: [StarWarsCharacterResult]?) {
        favoriteCharacters = starWarsCharacter
        self.characterListTableView.reloadData()
    }
    
    func onSaveFavoriteListError() {
        
    }
    
    
}


