//
//  HouseViewModelTests.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Oleksiy Chebotarov on 20/08/2021.
//

import XCTest
@testable import iOSTakeHomeChallenge

class HouseViewModelTests: XCTestCase {
    var houseViewModel: HouseViewModel!
    var housesViewModel: HousesViewModelType!
    var houses: [House]!
    
    override func setUpWithError() throws {
        let networkServiceLocal = NetworkServiceLocal(json: housesJson)
        let localDataFetcher = NetworkDataFetcher(networkingService: networkServiceLocal)
        housesViewModel = HousesViewModel(dataFetcher: localDataFetcher)

        housesViewModel.fetchHouses(completion: { response in
            switch response {
            case let .success(houses):
                self.houses = houses
            case let .failure(error):
                debugPrint(error.localizedDescription)
                XCTFail()
            }
        })
    }

    override func tearDownWithError() throws {
        houseViewModel = nil
        housesViewModel = nil
        houses = nil
    }

    func testFetchResponseContainsValues() throws {
        housesViewModel.fetchHouses(completion: { response in
            switch response {
            case let .success(houses):
                XCTAssertTrue(houses.count > 0)
            case let .failure(error):
                debugPrint(error.localizedDescription)
                XCTFail()
            }
        })
    }
    
    func testFirstItemInHouses() throws {
        guard let firstHouse = houses.first else {
            XCTFail()
            return
        }
            
        houseViewModel = HouseViewModel(house: firstHouse)
        XCTAssertEqual(houseViewModel.name, "House Algood")
        XCTAssertEqual(houseViewModel.region, "The Westerlands")
        XCTAssertEqual(houseViewModel.words, "")
    }
    
    func testSecondItemInHouses() throws {
        houseViewModel = HouseViewModel(house: houses[1])
        XCTAssertEqual(houseViewModel.name, "House Allyrion of Godsgrace")
        XCTAssertEqual(houseViewModel.region, "Dorne")
        XCTAssertEqual(houseViewModel.words, "No Foe May Pass")
    }
    
    func testLastItemInHouses() throws {
        guard let lastHouse = houses.last else {
            XCTFail()
            return
        }
            
        houseViewModel = HouseViewModel(house: lastHouse)
        XCTAssertEqual(houseViewModel.name, "House Baelish of Harrenhal")
        XCTAssertEqual(houseViewModel.region, "The Riverlands")
        XCTAssertEqual(houseViewModel.words, "")
    }
    
    func testFilterHousesByEmptyValue() throws {
        let filteredHouses = housesViewModel.filtering(houses: houses, target: "")
        XCTAssertEqual(filteredHouses.count, 10)
    }
    
    func testFilterHousesByAmb() throws {
        let target = "Amb"
        let filteredHouses = housesViewModel.filtering(houses: houses, target: target)
        XCTAssertEqual(filteredHouses.count, 2)
        XCTAssertTrue(filteredHouses.first?.name.contains(target) ?? false)
        XCTAssertTrue(filteredHouses.last?.name.contains(target) ?? false)
    }
    
    func testFilterHousesByArr() throws {
        let target = "Arr"
        let filteredHouses = housesViewModel.filtering(houses: houses, target: target)
        XCTAssertEqual(filteredHouses.count, 3)
        XCTAssertTrue(filteredHouses.first?.name.contains(target) ?? false)
    }
    
    func testFilterHousesByAbracadabra() throws {
        let target = "Abracadabra"
        let filteredHouses = housesViewModel.filtering(houses: houses, target: target)
        XCTAssertEqual(filteredHouses.count, 0)
    }
}
