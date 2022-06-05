//
//  Movie_Sorting_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Berkan Cimen on 4.05.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App

class Movie_Sorting_Tests: XCTestCase {
    
    let movies: [MovieViewModel] = MockWebService.getMockMovies()
    let sorting = MovieSort()

    func test_sorting_movies_with_rating() {
        
        let sortedMovies = sorting.sort({$0.rating}, movies)
        
        for index in 0...sortedMovies.count - 1 {
            guard sortedMovies.indices.contains(index + 1) else {return}
            let isBiggerThanNext = sortedMovies[index].rating > sortedMovies[index + 1].rating
            XCTAssertTrue(isBiggerThanNext)
        }
    }
    
    func test_sorting_movies_with_id() {
        
        let sortedMovies = sorting.sort({$0.id}, movies)
        
        for index in 0...sortedMovies.count - 1 {
            guard sortedMovies.indices.contains(index + 1) else {return}
            let isBiggerThanNext = sortedMovies[index].id > sortedMovies[index + 1].id
            XCTAssertTrue(isBiggerThanNext)
        }
    }


}
