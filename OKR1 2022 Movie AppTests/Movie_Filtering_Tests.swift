//
//  OKR1_2022_Movie_AppTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Berkan Cimen on 23.04.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import Combine

class Movie_Filtering_Tests: XCTestCase {
 
    let mockService: NetworkService = MockWebService()
    let sut = MovieFilter()
    private var mockMovies: [MovieViewModel] = []
    private var cancallable: AnyCancellable?
    
    override func setUp() {
        getMockMovies()
    }
   
    /// Movies should be filtered according to its' genre.
    func test_filtering_movie_with_genre() async {
        
        let actionGenre = GenresViewModel(genre: Genre(name: "Action", id: 8))

        let filteredMovies = sut.filter(mockMovies, MovieGenreSpecification(actionGenre))
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
        
        let above7Movies = sut.filter(mockMovies, MovieRatingSpecification(ratingEnum: .aboveSeven))
        XCTAssertEqual(1, above7Movies.count)
        XCTAssertEqual("Movie9", above7Movies.first?.name)
    }
    
    func test_filtering_movie_with_rating_between5_7() async {

        let between5and7Movies = sut.filter(mockMovies, MovieRatingSpecification(ratingEnum: .betweenFiveAndSeven))
        XCTAssertEqual(4, between5and7Movies.count)

        let between5and7MoviesNames = between5and7Movies.map {$0.name}
        XCTAssertTrue(between5and7MoviesNames.contains("Movie2"))
        XCTAssertTrue(between5and7MoviesNames.contains("Movie3"))
        XCTAssertTrue(between5and7MoviesNames.contains("Movie4"))
        XCTAssertFalse(between5and7MoviesNames.contains("Movie5"))
    }

    func test_filtering_movie_with_rating_below5() async {
        
        let below5Movies = sut.filter(mockMovies, MovieRatingSpecification(ratingEnum: .belowFive))
        XCTAssertEqual(2, below5Movies.count)
        XCTAssertEqual("Movie1", below5Movies.first?.name)
    }

    func test_filtering_movie_with_rating_none() async {
        
        let noneMovies = sut.filter(mockMovies, MovieRatingSpecification(ratingEnum: .none))
        XCTAssertEqual(2, noneMovies.count)
    }

    func test_andfiltering_movie_with_multi_spec() async {

        let comedyGenre = GenresViewModel(genre: Genre(name: "Comedy", id: 14))

        let below5Movies = sut.filter(mockMovies, MovieRatingSpecification(ratingEnum: .belowFive))
        // There are 2 movies which rating is below 5
        XCTAssertEqual(2, below5Movies.count)

        let filteredMovies = sut.filter(mockMovies, MovieGenreSpecification(comedyGenre))
        // There are 2 movies which genre is Comedy
        XCTAssertEqual(2, filteredMovies.count)

        let comedyAndRatingBelow5Movies = sut.filter(mockMovies, AndSpecification(
                MovieGenreSpecification(comedyGenre), MovieRatingSpecification(ratingEnum: .belowFive)))
        // There are 2 movies which genre is Comedy and rating is below 5
        XCTAssertEqual(1, comedyAndRatingBelow5Movies.count)

    }
    
    func getMockMovies() {
        
        let response = mockService.fetch(type: MovieResponse.self, url: EndPoints.popular, page: nil)
        cancallable = response
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] in
                self?.mockMovies = $0.results.map(MovieViewModel.init)
            })
    }
}
