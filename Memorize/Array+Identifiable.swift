//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Svetlana Bolotova on 22.10.2020.
//  Copyright © 2020 Svetlana Bolotova. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
func firstIndex (matching: Element) -> Int? {
    for index in 0..<self.count {
        if self[index].id == matching.id {
            return index
        }
    }
    return nil //TODO: bogus
}
}
