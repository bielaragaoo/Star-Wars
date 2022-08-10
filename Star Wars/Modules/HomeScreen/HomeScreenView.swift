//
//  HomeScreenView.swift
//  Star Wars
//
//  Created by Gabriel Aragao on 10/07/22.
//

import UIKit

class HomeScreenView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var presenter: ViewToPresenterHomeScreenProtocol?
    var label: String?
    var identifier = "Cell reuse identifier"
    var starData: StarWarsCharacter?
    var characters: [StarWarsCharacterResult?]?
    var indexNext: String?
    
    
    @IBOutlet weak var characterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        presenter?.viewDidLoad(path: nil)
        characterListTableView.prefetchDataSource = self
        characterListTableView.delegate = self
        characterListTableView.dataSource = self
        characterListTableView.register(HomeScreenViewTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    func tableView(_ characterListTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters?.count ?? 1
    }
    
    func tableView(_ characterListTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = characterListTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomeScreenViewTableViewCell

        cell.setup(starData: characters?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(characters?[indexPath.row] != nil){
            presenter?.router?.pushToDetailScreen(on: self, starWarsCharacterResult: characters![indexPath.row]!)
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
extension HomeScreenView{
    
    func setupTabBar(){
        self.navigationItem.title = "Home Screen"
        let searchController = UISearchController()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self as? UISearchBarDelegate
        self.navigationItem.searchController = searchController
    }
}
