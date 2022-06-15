//
//  Movie_Sorting_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Berkan Cimen on 4.05.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App

class Movie_Sorting_Tests: XCTestCase {
    
    let mockService: NetworkService = WebServiceFactory.create()
    let sorting = MovieSort()

    func test_sorting_movies_with_rating() async {
        
        var movies: [MovieViewModel] = []
        do {
            if let mockMovies = await getMockMovies() {
                movies = mockMovies
            } else {
                XCTFail("json parsing failed")
            }
        }
        
        let sortedMovies = sorting.sort({$0.rating}, movies)
        
        for index in 0...sortedMovies.count - 1 {
            guard sortedMovies.indices.contains(index + 1) else {return}
            let isBiggerThanNext = sortedMovies[index].rating > sortedMovies[index + 1].rating
            XCTAssertTrue(isBiggerThanNext)
        }
    }
    
    func test_sorting_movies_with_id() async {
        
        var movies: [MovieViewModel] = []
        do {
            if let mockMovies = await getMockMovies() {
                movies = mockMovies
            } else {
                XCTFail("json parsing failed")
            }
        }
        
        let sortedMovies = sorting.sort({$0.id}, movies)
        
        for index in 0...sortedMovies.count - 1 {
            guard sortedMovies.indices.contains(index + 1) else {return}
            let isBiggerThanNext = sortedMovies[index].id > sortedMovies[index + 1].id
            XCTAssertTrue(isBiggerThanNext)
        }
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
