//
//  MovieDetailViewModel_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 29.06.2022.
//

import XCTest
import SwiftUI

class MovieDetailViewModel_Tests: XCTestCase {
    
    var sut: MovieDetailViewModel!

    override func setUp() {
        sut = MovieDetailViewModel(service: MockWebService(), movieId: 1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_movie_detail_fetch() {
        XCTAssertEqual("MovieDefault", sut.movieDetail.name)
        sut.getMovieDetail()
        let expectation = self.expectation(description: "Test")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual("Movie1", sut.movieDetail.name)
    }
    
    func test_movie_detail_fetch_error() {
        sut = MovieDetailViewModel(service: MockWebService(), movieId: 2)
        XCTAssertEqual("MovieDefault", sut.movieDetail.name)
        sut.getMovieDetail()
        let expectation = self.expectation(description: "Test")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual("MovieDefault", sut.movieDetail.name)
    }
    
}
