//
//  SearchViewModel_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 9.10.2022.
//

import XCTest

class SearchViewModel_Tests: XCTestCase {

    var sut: SearchViewModel!
    
    override func setUp() {
        sut = SearchViewModel(service: MockWebService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_search_movies() async {
        await getMovies(searchText: "Search Test")
        let expectation = self.expectation(description: "Test")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.filteredMovies.count, 9)
        XCTAssertEqual(sut.filteredMovies.first?.name, "Movie1")
    }
    
    func getMovies(searchText: String) async {
        sut.getMovies(searchText)
        let expectation = self.expectation(description: "Fetch Movies Exp")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 1, handler: nil)
    }
}