//
//  Theme.swift
//  Memorize
//
//  Created by user185236 on 1/8/21.
//  Copyright © 2021 Svetlana Bolotova. All rights reserved.
//

import Foundation
import SwiftUI

let themes = [halloween, animals, christmas]

struct Theme {
    let name: String
    var emojiList: [String]
    let backgroundColor: Color
    let cardColor: Color
    let timerColor: Color
    
    init(
        name: String,
        emojiList: [String],
        backgroundColor: Color,
        cardColor: Color,
        timerColor: Color
    ) {
        self.name = name
        self.emojiList = emojiList
        self.backgroundColor = backgroundColor
        self.cardColor = cardColor
        self.timerColor = timerColor
    }
}

let animals = Theme(
    name: "Animals",
    emojiList: ["🐶","🐱","🐭","🐹","🐰","🦊","🐼","🐨","🐯","🦁","🐮","🐸","🐵","🐤"],
    backgroundColor: Color.blue,
    cardColor: Color.yellow,
    timerColor: Color.gray
)

let christmas = Theme(
    name: "Christmas",
    emojiList: ["🤶🏻","🎅🏻","🎄","⛄️","❄️","🎁"],
    backgroundColor: Color.red,
    cardColor: Color.white,
    timerColor: Color.green
)

let halloween = Theme(
    name: "Halloween",
    emojiList: ["👻","🎃","🕷","👺","🍬","🍭","💀","🧠","👁"],
    backgroundColor: Color.black,
    cardColor: Color.orange,
    timerColor: Color.red
)
