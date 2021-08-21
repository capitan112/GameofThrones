//
//  BooksViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 18/08/2021.
//

import Foundation

protocol BooksViewModelType {
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void)
}

class BooksViewModel: BooksViewModelType {
    private(set) var dataFetcher: NetworkDataFetcherProtocol!

    init(dataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }

    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        dataFetcher.fetchBooks(completion: completion)
    }
}
