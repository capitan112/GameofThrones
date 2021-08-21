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
    
    private let seasonDict = [
                      "Season 1": "I",        
                      "Season 2": "II",
                      "Season 3": "III",
                      "Season 4": "IV",
                      "Season 5": "V",
                      "Season 6": "VI",
                      "Season 7": "VII",
                      "Season 8": "VIII"
    ]
    
    var seasons: String {
        get {
            return filtering(seasons: character.tvSeries)
        }
    }
    
    func filtering(seasons: [String]) -> String {
        let arraySize = max(seasons.count, seasonDict.count) + 1
        var seasonsArray = Array(repeating: "", count: arraySize)
        for season in seasons {
            if let lastDigit = Int(String(season.suffix(1))) {
                seasonsArray[lastDigit] = seasonDict[season] ?? ""
            }
        }
        
        var leftBound = ""
        var rightBound = ""
        var result = ""
        for index in 1..<seasonsArray.count {
            if seasonsArray[index] != ""  {
                if leftBound.isEmpty {
                    leftBound = seasonsArray[index]
                }
                rightBound = seasonsArray[index]
            } else if !leftBound.isEmpty {
                if !result.isEmpty {
                    result += ", "
                }
                result += leftBound != rightBound ? leftBound + "-" + rightBound : leftBound
                leftBound = ""
                rightBound = ""
//                result += " "
            }
        }
        
        if !leftBound.isEmpty {
            if !result.isEmpty {
                result += ", "
            }
            result += leftBound != rightBound ? leftBound + "-" + rightBound : leftBound
        }
        

        return result
    }
}
