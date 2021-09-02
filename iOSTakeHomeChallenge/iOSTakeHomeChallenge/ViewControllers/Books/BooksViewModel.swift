//
//  BooksViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 18/08/2021.
//

import Foundation

protocol BooksViewModelType {
    var cachedBooks: [Book] { get set }
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void)
}

class BooksViewModel: BooksViewModelType {
    private(set) var dataFetcher: NetworkDataFetcherProtocol!
    var cachedBooks: [Book] = []

    init(dataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }

    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        dataFetcher.fetchBooks(completion: completion)
    }
}
