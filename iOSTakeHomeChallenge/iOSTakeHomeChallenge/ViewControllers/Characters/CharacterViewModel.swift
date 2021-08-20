//
//  CharacterViewModel.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 20/08/2021.
//

import Foundation

struct CharacterViewModel {
    var character: Character
    
    var name: String {
        return character.name
    }
    
    var culture: String {
        return character.culture
    }
    
    var born: String {
        return character.born
    }
    
    var died: String {
        return character.died
    }
    
    
    var seasons: String {
        get {
            return filtering(seasons: character.tvSeries)
        }
    }
    
    func filtering(seasons: [String]) -> String {
        var filteredSeasons = [String]()
        let seasonDict = ["Season 1": "I",
                          "Season 2": "II",
                          "Season 3": "III",
                          "Season 4": "IV",
                          "Season 5": "V",
                          "Season 6": "VI",
                          "Season 7": "VII",
                          "Season 8": "VIII"
        ]
        
        for season in seasons {
            if let filtered = seasonDict.filter({ $0.key == season }).values.first {
                filteredSeasons.append(filtered)
            }
        }
        
        return filteredSeasons.joined(separator: ", ")
    }
}
