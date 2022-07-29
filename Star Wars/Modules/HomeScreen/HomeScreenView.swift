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
    @IBOutlet weak var characterListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        characterListTableView.delegate = self
        characterListTableView.dataSource = self
        characterListTableView.register(HomeScreenViewTableViewCell.self, forCellReuseIdentifier: identifier)

    }
    
    func tableView(_ characterListTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (starData?.results.count)
        return starData?.results.count ?? 1
    }
    
    func tableView(_ characterListTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = characterListTableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! HomeScreenViewTableViewCell
        cell.label.text = starData?.results[indexPath.row].name
        print(cell.label.text)
        return cell
    }
    
}

extension HomeScreenView: PresenterToViewHomeScreenProtocol {
    func onGetCharacterListSucess(_ starWarsCharacter: StarWarsCharacter) {
        self.starData = starWarsCharacter
        self.characterListTableView.reloadData()
    }
    
    func onGetCharacterListError() {
    }
}

