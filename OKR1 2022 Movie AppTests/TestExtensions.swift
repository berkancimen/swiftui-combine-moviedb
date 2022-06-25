//
//  TestExtensions.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 25.06.2022.
//

import Foundation

extension Thread {
    var isRunningXCTest: Bool {
        threadDictionary.allKeys
            .contains {
                ($0 as? String)?
                    .range(of: "XCTest", options: .caseInsensitive) != nil
            }
    }
}
