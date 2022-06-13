//
//  StringExtensions.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 13.06.2022.
//

import Foundation

extension String {
    
    func urlHostAllowedString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
}
