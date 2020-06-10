//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Dysson Vielmann on 6/1/20.
//  Copyright © 2020 Nossyd. All rights reserved.
//

import Foundation


// extension is added only to Identifiable types of arrays
// ignores any other array that is NOT identifiable
extension Array where Element: Identifiable {
    // func to find index of card for grid layout
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
}
