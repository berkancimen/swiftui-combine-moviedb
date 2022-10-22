//
//  MovieViewModel_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 22.10.2022.
//

import XCTest

class MovieModel_Tests: XCTestCase {
    
    var sut: MovieViewModel!
    
    override func setUp() {
        sut = MovieViewModel(movie: Movie(title: "Movie1", id: 1, genre_ids: [5], vote_average: 2.2, poster_path: "/Poster_Path", release_date: "2021-12-12"))
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_movie_info() {
        XCTAssertEqual(sut.name, "Movie1")
        XCTAssertEqual(sut.id, 1)
        XCTAssertEqual(sut.genres, [5])
        XCTAssertEqual(sut.ratingEnum, .belowFive)
        XCTAssertEqual(sut.rating, 2.2)
        XCTAssertEqual(sut.ratingString, "2.2")
        XCTAssertEqual(sut.imageUrl, "https://image.tmdb.org/t/p/w500/Poster_Path")
        XCTAssertEqual(sut.overview, "")
        XCTAssertEqual(sut.releaseDate, "2021-12-12")
    }
    
    func test_default_movie_info() {
        XCTAssertEqual(MovieViewModel.default.name, "Movie 1")
        XCTAssertEqual(MovieViewModel.default.id, 0)
        XCTAssertEqual(MovieViewModel.default.genres, [])
        XCTAssertEqual(MovieViewModel.default.ratingEnum, .belowFive)
        XCTAssertEqual(MovieViewModel.default.rating, 2.3)
        XCTAssertEqual(MovieViewModel.default.ratingString, "2.3")
        XCTAssertEqual(MovieViewModel.default.imageUrl, "https://image.tmdb.org/t/p/w500/74xTEgt7R36Fpooo50r9T25onhq.jpg")
        XCTAssertEqual(MovieViewModel.default.overview, "Description")
        XCTAssertEqual(MovieViewModel.default.releaseDate, "2021-12-04")
    }

}
