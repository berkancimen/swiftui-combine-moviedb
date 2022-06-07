//
//  OKR1_2022_Movie_AppTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Berkan Cimen on 23.04.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App

class Movie_Filtering_Tests: XCTestCase {
 
    let mockService: NetworkService = WebServiceFactory.create()
    let movieFilter = MovieFilter()
    
    /// Movies should be filtered according to its' genre.
    func test_filtering_movie_with_genre() async {
        
        var movies: [MovieViewModel] = []
        do {
            if let mockMovies = await getMockMovies() {
                movies = mockMovies
            } else {
                XCTFail()
            }
        }

        let actionGenre = GenresViewModel(genre: Genre(name: "Action", id: 8))

        let filteredMovies = movieFilter.filter(movies, MovieGenreSpecification(actionGenre))
        XCTAssertEqual(2, filteredMovies.count)

        let notContainsMovie1 = filteredMovies.contains { movie in
            return movie.name == "Movie1"
        }
        XCTAssertFalse(notContainsMovie1)

        let containsMovie2 = filteredMovies.contains { movie in
            return movie.name == "Movie2"
        }
        XCTAssertTrue(containsMovie2)

        let containsMovie4 = filteredMovies.contains { movie in
            return movie.name == "Movie4"
        }
        XCTAssertTrue(containsMovie4)

        for movie in filteredMovies {
            XCTAssertEqual(movie.genres.contains(8), true)
        }
    }
    
    /// Movies should be filtered according to its' rating.
    func test_filtering_movie_with_rating_above7() async {
        
        var movies: [MovieViewModel] = []
        do {
            if let mockMovies = await getMockMovies() {
                movies = mockMovies
            } else {
                XCTFail()
            }
        }
                        
        let above7Movies = movieFilter.filter(movies, MovieRatingSpecification(ratingEnum: .aboveSeven))
        XCTAssertEqual(1, above7Movies.count)
        XCTAssertEqual("Movie9", above7Movies.first?.name)
    }
    
    func test_filtering_movie_with_rating_between5_7() async {
        
        var movies: [MovieViewModel] = []
        do {
            if let mockMovies = await getMockMovies() {
                movies = mockMovies
            } else {
                XCTFail()
            }
        }

        let between5and7Movies = movieFilter.filter(movies, MovieRatingSpecification(ratingEnum: .betweenFiveAndSeven))
        XCTAssertEqual(4, between5and7Movies.count)

        let between5and7MoviesNames = between5and7Movies.map {$0.name}
        XCTAssertTrue(between5and7MoviesNames.contains("Movie2"))
        XCTAssertTrue(between5and7MoviesNames.contains("Movie3"))
        XCTAssertTrue(between5and7MoviesNames.contains("Movie4"))
        XCTAssertFalse(between5and7MoviesNames.contains("Movie5"))
    }

    func test_filtering_movie_with_rating_below5() async {
        
        var movies: [MovieViewModel] = []
        do {
            if let mockMovies = await getMockMovies() {
                movies = mockMovies
            } else {
                XCTFail()
            }
        }

        let below5Movies = movieFilter.filter(movies, MovieRatingSpecification(ratingEnum: .belowFive))
        XCTAssertEqual(2, below5Movies.count)
        XCTAssertEqual("Movie1", below5Movies.first?.name)
    }

    func test_filtering_movie_with_rating_none() async {
        
        var movies: [MovieViewModel] = []
        do {
            if let mockMovies = await getMockMovies() {
                movies = mockMovies
            } else {
                XCTFail()
            }
        }

        let noneMovies = movieFilter.filter(movies, MovieRatingSpecification(ratingEnum: .none))
        XCTAssertEqual(2, noneMovies.count)
    }

    func test_andfiltering_movie_with_multi_spec() async {
        
        var movies: [MovieViewModel] = []
        do {
            if let mockMovies = await getMockMovies() {
                movies = mockMovies
            } else {
                XCTFail()
            }
        }

        let comedyGenre = GenresViewModel(genre: Genre(name: "Comedy", id: 14))

        let below5Movies = movieFilter.filter(movies, MovieRatingSpecification(ratingEnum: .belowFive))
        // There are 2 movies which rating is below 5
        XCTAssertEqual(2, below5Movies.count)

        let filteredMovies = movieFilter.filter(movies, MovieGenreSpecification(comedyGenre))
        // There are 2 movies which genre is Comedy
        XCTAssertEqual(2, filteredMovies.count)

        let comedyAndRatingBelow5Movies = movieFilter.filter(movies, AndSpecification(
                MovieGenreSpecification(comedyGenre), MovieRatingSpecification(ratingEnum: .belowFive)))
        // There are 2 movies which genre is Comedy and rating is below 5
        XCTAssertEqual(1, comedyAndRatingBelow5Movies.count)

    }
    
    func getMockMovies() async -> [MovieViewModel]? {
        do {
            let response: MovieResponse = try await mockService.fetch(url: EndPoints.popular, page: nil)
            let items = response.results
            return items.map(MovieViewModel.init)
        } catch {
            return nil
        }
        
    }
}
