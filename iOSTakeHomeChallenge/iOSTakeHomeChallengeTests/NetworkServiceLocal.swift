//
//  NetworkServiceLocal.swift
//  iOSTakeHomeChallengeTests
//
//  Created by Oleksiy Chebotarov on 19/08/2021.
//

import Foundation
@testable import iOSTakeHomeChallenge

class NetworkServiceLocal: NetworkProtocol {
    private var dataSourceJson: String

    init(json: String) {
        dataSourceJson = json
    }

    func request(path _: String, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(.success(dataSourceJson.data(using: .utf8)!))
    }
}
