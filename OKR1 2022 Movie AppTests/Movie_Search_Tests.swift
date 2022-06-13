//
//  Movie_Search_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Berkan Cimen on 13.06.2022.
//

import XCTest

class Movie_Search_Tests: XCTestCase {
    
    func test_url_host_allowed_text() {
        
        let searchText = "Lord of the Rings"
        let expectedEncodedText = "Lord%20of%20the%20Rings"
        
        XCTAssertEqual(searchText.urlHostAllowedString(), expectedEncodedText)
    }
}
