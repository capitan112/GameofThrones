//
//  Character.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 18/08/2021.
//

import Foundation

struct Character: Decodable {
    let url: String
    let name: String
    let gender: String
    let culture: String
    let born: String
    let died: String
    let aliases:  [String]
    let father: String
    let mother: String
    let spouse: String
    let allegiances: [String]
    let books: [String]
    let povBooks: [String]
    let tvSeries: [String]
    let playedBy: [String]
}
