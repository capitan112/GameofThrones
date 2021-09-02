//
//  HousesViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 19/08/2021.
//

import Foundation
import UIKit

protocol HousesViewModelType {
    var cachedHouses: [House] { get }
    var filteredHouses: [House] { get }
    func fetchHouses(completion: @escaping (Result<[House], Error>) -> Void)
    func filtering(with target: String)
    func setUp(houses: [House])
    func discardSearching()
}

class HousesViewModel: RootViewModel, HousesViewModelType {
    private(set) var cachedHouses: [House] = []
    private(set) var filteredHouses: [House] = []

    func fetchHouses(completion: @escaping (Result<[House], Error>) -> Void) {
        dataFetcher.fetchHouses(completion: completion)
    }

    func setUp(houses: [House]) {
        cachedHouses = houses
        filteredHouses = houses
    }

    func discardSearching() {
        filteredHouses = cachedHouses
    }

    func filtering(with target: String) {
        if target.isEmpty {
            discardSearching()

            return
        }

        filteredHouses = cachedHouses.filter { (house: House) -> Bool in
            house.name.lowercased().range(of: target, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
    }
}
