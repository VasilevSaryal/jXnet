//
//  Structures.swift
//  jXnet
//
//  Created by iOSDeveloperYkt on 08.06.2020.
//  Copyright © 2020 Vasiliev S.I. All rights reserved.
//

import Foundation

struct KanaData {
    let id: Int!
    let kana: String!
    let russian: String!
    let english: String!
    var shortLearning = 0
    var deepLearning = 0
    var mnemonics = ""
    var lastDate: Date?
    
}

struct RangeForGradation {
    let start: Int!
    let end: UInt32!
}

struct TwoInteger { //для прохождения курса от jXnet и упражнение на сопоставление
    let first: Int!
    var second = 0
}
