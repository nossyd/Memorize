//
//  Array+Only.swift
//  Memorize
//
//  Created by Dysson Vielmann on 6/2/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import Foundation

// returns only thing in array
// extends to all arrays
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
