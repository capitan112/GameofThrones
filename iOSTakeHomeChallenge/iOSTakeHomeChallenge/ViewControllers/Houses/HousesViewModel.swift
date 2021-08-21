//
//  HousesViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 19/08/2021.
//

import Foundation

protocol HousesViewModelType {
    func fetchHouses(completion: @escaping (Result<[House], Error>) -> Void)
    func filtering(houses: [House], target: String) -> [House]
}

class HousesViewModel: RootViewModel, HousesViewModelType {
    func fetchHouses(completion: @escaping (Result<[House], Error>) -> Void) {
        dataFetcher.fetchHouses(completion: completion)
    }

    func filtering(houses: [House], target: String) -> [House] {
        if target.isEmpty {
            return houses
        }

        let filteredHouses = houses.filter { (house: House) -> Bool in
            house.name.lowercased().range(of: target, options: .caseInsensitive, range: nil, locale: nil) != nil
        }

        return filteredHouses
    }
}
