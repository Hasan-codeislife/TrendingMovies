//
//  Reactive.swift
//  MovieWorld
//
//  Created by Hassan Personal on 09.04.22.
//

import Foundation

class Reactive<T> {
    typealias Listner = (T) -> Void
    var listner: [Listner?] = [Listner?]()
    
    var value: T {
        didSet {
            for l in listner {
                l?(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listner: Listner?) {
        self.listner.append(listner)
        listner?(value)
    }
}
