//
//  Array+Only.swift
//  Memorize
//
//  Created by Svetlana Bolotova on 29.10.2020.
//  Copyright © 2020 Svetlana Bolotova. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
