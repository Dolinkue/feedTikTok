//
//  Section.swift
//  feedTikTok
//
//  Created by Nicolas Dolinkue on 27/01/2023.
//

import Foundation

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
