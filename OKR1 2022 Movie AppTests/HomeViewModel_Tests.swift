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
    override func setUpWithError() throws {
        sut = ViewModelHome(service: MockWebService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fetch_genre() async {
        XCTAssertEqual(sut.genres.count, 0)
        await sut.getGenres()
        let expectation = self.expectation(description: "Test")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        await waitForExpectations(timeout: 1, handler: nil)
        XCTAssertEqual(sut.genres.count, 3)
        XCTAssertEqual(sut.genres.first?.genreName, "Action")
    }

}
