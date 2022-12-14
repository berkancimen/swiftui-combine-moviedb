//
//  HomeViewModel_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 29.06.2022.
//

import XCTest

class HomeViewModel_Tests: XCTestCase {
    
    var sut: ViewModelHome!
    
    @MainActor
    override func setUp() {
        sut = ViewModelHome(service: MockWebService())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fetch_genre() {
        XCTAssertEqual(sut.genres.count, 0)
        sut.getGenres()
        let expectation = self.expectation(description: "Fetch Genre Exp")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertEqual(sut.genres.count, 3)
        XCTAssertEqual(sut.genres.first?.genreName, "Action")
    }
    
    func test_get_popular_movies() {
        XCTAssertEqual(sut.popularMovies.count, 0)
        sut.getPopularMovies()
        let expectation = self.expectation(description: "Fetch Popular Exp")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.popularMovies.count, 9)
        XCTAssertEqual(sut.popularMovies.first?.name, "Movie1")
    }
    
    func test_get_trending_movies() {
        XCTAssertEqual(sut.trengingMovies.count, 0)
        sut.getTrendingMovies()
        let expectation = self.expectation(description: "Fetch Trending Exp")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.trengingMovies.count, 9)
        XCTAssertEqual(sut.trengingMovies.first?.name, "Movie1")
    }
    
    func test_get_topRated_movies() {
        XCTAssertEqual(sut.topRatedMovies.count, 0)
        sut.getTopRatedMovies()
        let expectation = self.expectation(description: "Fetch TopRated Exp")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.topRatedMovies.count, 9)
        XCTAssertEqual(sut.topRatedMovies.first?.name, "Movie1")
    }

}
