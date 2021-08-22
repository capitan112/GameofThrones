//
//  GCDBlackBox.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 22/08/2021.
//

import Foundation

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
