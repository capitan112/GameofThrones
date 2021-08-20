//
//  RootViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 20/08/2021.
//

import Foundation

class RootViewModel {
    private(set) var dataFetcher: NetworkDataFetcherProtocol!

    init(dataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
}
