//
//  NetworkDataFetcher.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 18/08/2021.
//

import Foundation

enum ConversionFailure: Error {
    case invalidData
    case missingData
    case responceError
}

protocol NetworkDataFetcherProtocol {
    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void)
    func fetchHouses(completion: @escaping (Result<[House], Error>) -> Void)
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}

final class NetworkDataFetcher: NetworkDataFetcherProtocol {
    var networkingService: NetworkProtocol

    init(networkingService: NetworkProtocol = NetworkService()) {
        self.networkingService = networkingService
    }

    func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        fetchGenericJSONData(path: RequestConstant.Server.APIPathBook, response: completion)
    }
    
    func fetchHouses(completion: @escaping (Result<[House], Error>) -> Void) {
        fetchGenericJSONData(path: RequestConstant.Server.APIPathHouse, response: completion)
    }

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {   fetchGenericJSONData(path: RequestConstant.Server.APIPathCharacters, response: completion)
    }
    
func fetchGenericJSONData<T: Decodable>(path: String, response: @escaping (Result<T, Error>) -> Void) {
        networkingService.request(path: path) { dataResponse in
            guard let data = try? dataResponse.get() else {
                response(.failure(ConversionFailure.responceError))
                return
            }

            self.decodeJSON(from: data, completion: response)
        }
    }

    private func decodeJSON<T: Decodable>(from data: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let data = data else {
            completion(.failure(ConversionFailure.missingData))
            return
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        do {
            let result = Result(catching: {
                try decoder.decode(T.self, from: data)
            })

            completion(result)
        }
    }
}
