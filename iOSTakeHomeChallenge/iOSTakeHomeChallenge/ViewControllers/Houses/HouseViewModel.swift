//
//  HouseViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 19/08/2021.
//

import Foundation

class HouseViewModel {
    private(set) var name: String
    private(set) var region: String
    private(set) var words: String

    init(house: House) {
        self.name = house.name
        self.region = house.region
        self.words = house.words
    }
}
