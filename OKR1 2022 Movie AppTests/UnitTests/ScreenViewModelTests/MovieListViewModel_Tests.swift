//
//  MovieListViewModel_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 3.07.2022.
//

import XCTest

class MovieListViewModel_Tests: XCTestCase {
    
    var sut: MovieListViewModel!

    override func setUp() {
        sut = MovieListViewModel(service: MockWebService(), screenName: ScreenNames.trending)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_get_movies() {
        XCTAssertEqual(sut.filteredMovies.count, 0)
        sut.getMovies()
        XCTAssertEqual(sut.filteredMovies.count, 9)
        XCTAssertEqual(sut.filteredMovies.first?.name, "Movie1")
    }
    
    func test_screenName_and_endPoint() {
        XCTAssertEqual(sut.screenName, ScreenNames.trending.getScreenName())
        XCTAssertEqual(sut.getEndPoint().url(), ScreenNames.trending.getEndPoint().url())
    }
    
    func test_should_load_more() {
        XCTAssertEqual(sut.filteredMovies.count, 0)
        sut.getMovies()
        XCTAssertEqual(sut.filteredMovies.count, 9)
        sut.shouldLoadMore(movie: sut.filteredMovies.last!)
        let expectation = self.expectation(description: "Should Load More Exp")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.filteredMovies.count, 18)
    }
    
    func test_should_not_load_more() {
        XCTAssertEqual(sut.filteredMovies.count, 0)
        sut.getMovies()
        XCTAssertEqual(sut.filteredMovies.count, 9)
        sut.shouldLoadMore(movie: sut.filteredMovies.first!)
        let expectation = self.expectation(description: "Should Load More Exp")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.filteredMovies.count, 9)
    }
    
    func test_filtering_with_rating() {
        sut.getMovies()
        sut.filterMovie(rating: Ratings.aboveSeven)
        XCTAssertEqual(1, sut.filteredMovies.count)
        XCTAssertEqual("Movie9", sut.filteredMovies.first?.name)
    }
    
    func test_filtering_none() {
        sut.getMovies()
        sut.filterMovie()
        XCTAssertEqual(9, sut.filteredMovies.count)
        XCTAssertEqual("Movie1", sut.filteredMovies.first?.name)
    }
    
    func test_sorting_rating() {
        sut.getMovies()
        sut.filterMovie(sort: .rating)
        XCTAssertEqual("Movie7", sut.filteredMovies.first?.name)
    }
    
    func test_sort_date() {
        sut.getMovies()
        sut.filterMovie(sort: .date)
        XCTAssertEqual("Movie8", sut.filteredMovies.first?.name)
        XCTAssertEqual("Movie9", sut.filteredMovies.last?.name)
    }
    
    func test_fetch_movie_with_error() {
        sut.setEndPoint(endPoint: .search(""))
        sut.getMovies()
        XCTAssertEqual(0, sut.filteredMovies.count)
    }
}
