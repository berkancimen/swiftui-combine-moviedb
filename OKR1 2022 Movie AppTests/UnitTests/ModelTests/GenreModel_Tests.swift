//
//  GenreViewModel_Tests.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 22.10.2022.
//

import XCTest

class GenreModel_Tests: XCTestCase {
    
    var sut: GenresViewModel!
    
    override func setUp() {
        sut = GenresViewModel(genre: Genre(name: "Comedy", id: 8))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_genre_info() {
        XCTAssertEqual(sut.genreName, "Comedy")
        XCTAssertEqual(sut.genreId, 8)
    }
    
    func test_default_genre_info() {
        XCTAssertEqual(GenresViewModel.`default`.genreName, "Action")
        XCTAssertEqual(GenresViewModel.`default`.genreId, 1)
    }
    
    

}
