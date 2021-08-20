//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class HousesViewController: RootViewController, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var searchBar: BlackSearchBar!
    private var viewModel: HousesViewModelType = HousesViewModel()
    var cachedHouses: [House] = []
    private var filteredHouses: [House] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHouses()
        searchBar.delegate = self
    }

    private func getHouses() {
        viewModel.fetchHouses(completion: { response in
            switch response {
            case let .success(houses):
                self.loadData(houses: houses)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        })
    }
    
    func loadData(houses: [House]) {
        cachedHouses = houses
        filteredHouses = cachedHouses
        reload(tableView: tableView)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredHouses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HouseTableViewCell.reuseIdentifierCell) as! HouseTableViewCell
        cell.setupWith(house: HouseViewModel(house: filteredHouses[indexPath.row]))
        
        return cell
    }
    
// MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredHouses = viewModel.filtering(houses: cachedHouses, target: searchText)
        reload(tableView: tableView)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

class HouseTableViewCell: UITableViewCell {
    static let reuseIdentifierCell = "HouseTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    func setupWith(house: HouseViewModel) {
        nameLabel.text = house.name
        regionLabel.text = house.region
        if house.words.isEmpty {
            wordsLabel.isHidden = true
        } else {
            wordsLabel.isHidden = false
            wordsLabel.text = house.words
        }
    }
}
