//
//  HousesViewController.swift
//  iOSTakeHomeChallenge
//
//  Created by James Malcolm on 09/03/2021.
//

import Foundation
import UIKit

class HousesViewController: RootViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: BlackSearchBar!
    private var viewModel: HousesViewModelType = HousesViewModel()
    var cachedHouses: [House] = []
    private var filteredHouses: [House] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator(center: view.center)
        getHouses()
        searchBar.delegate = self
    }

    private func getHouses() {
        startActivityIndicator()
        viewModel.fetchHouses(completion: { response in
            switch response {
            case let .success(houses):
                self.loadData(houses: houses)
            case let .failure(error):
                debugPrint(error.localizedDescription)
                self.showAlertAndStopActivityIndicator()
            }
        })
    }

    func loadData(houses: [House]) {
        cachedHouses = houses
        filteredHouses = cachedHouses
        reload(tableView: tableView)
        stopActivityIndicator()
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        filteredHouses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HouseTableViewCell.reuseIdentifierCell) as! HouseTableViewCell
        cell.setupWith(house: HouseViewModel(house: filteredHouses[indexPath.row]))

        return cell
    }
}

extension HousesViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        filteredHouses = viewModel.filtering(houses: cachedHouses, target: searchText)
        reload(tableView: tableView)
    }

    func searchBarTextDidBeginEditing(_: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        filteredHouses = cachedHouses
        searchBar.resignFirstResponder()
        reload(tableView: tableView)
    }
}

class HouseTableViewCell: UITableViewCell {
    static let reuseIdentifierCell = "HouseTableViewCell"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    @IBOutlet var wordsLabel: UILabel!

    override func prepareForReuse() {
        nameLabel.text = ""
        regionLabel.text = ""
        wordsLabel.text = ""
    }

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
