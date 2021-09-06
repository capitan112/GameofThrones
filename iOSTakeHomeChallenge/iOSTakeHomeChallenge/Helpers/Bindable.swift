//
//  Bindable.swift
//  iOSTakeHomeChallenge
//
//  Created by Oleksiy Chebotarov on 05/09/2021.
//

import Foundation

class Bindable<T> {
    typealias Listener = (T) -> Void

    var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }

    init(_ value: T) {
        self.value = value
    }
}
