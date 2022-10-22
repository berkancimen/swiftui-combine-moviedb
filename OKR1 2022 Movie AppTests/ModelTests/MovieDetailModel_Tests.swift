//
//  MovieDetailViewModel_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 22.10.2022.
//

import Foundation

import XCTest

class MovieDetailModel_Tests: XCTestCase {
    
    var sut: MovieDetailModelViewModel!
    
    override func setUp() {
        sut = MovieDetailModelViewModel(movie: MovieDetailModel(name: "Movie 1"))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_movie_detail_info() {
        XCTAssertEqual("Movie 1", sut.name)
        XCTAssertEqual(0, sut.id)
        XCTAssertEqual(Ratings.none, sut.ratingEnum)
        XCTAssertEqual(0.0, sut.rating)
        XCTAssertEqual("0.0", sut.ratingString)
        XCTAssertEqual("0.0", sut.ratingString)
        XCTAssertEqual("https://image.tmdb.org/t/p/w500", sut.imageUrl)
        XCTAssertEqual("", sut.overview)
        XCTAssertEqual("", sut.releaseDate)
        XCTAssertEqual(nil, sut.originalLanguage)
        XCTAssertEqual("N/A", sut.revenue)
        XCTAssertEqual("0 minutes", sut.duration)
    }
}
