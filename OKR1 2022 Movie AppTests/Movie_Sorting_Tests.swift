//
//  Movie_Sorting_Tests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Berkan Cimen on 4.05.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import Combine

class Movie_Sorting_Tests: XCTestCase {
    
    let mockService: NetworkService = MockWebService()
    let sut = MovieSort()
    private var mockMovies: [MovieViewModel] = []
    private var cancallable: AnyCancellable?
    
    override func setUpWithError() throws {
        getMockMovies()
    }

    func test_sorting_movies_with_rating() async {
        
        let sortedMovies = sut.sort({$0.rating}, mockMovies)
        
        for index in 0...sortedMovies.count - 1 {
            guard sortedMovies.indices.contains(index + 1) else {return}
            let isBiggerThanNext = sortedMovies[index].rating > sortedMovies[index + 1].rating
            XCTAssertTrue(isBiggerThanNext)
        }
    }
    
    func test_sorting_movies_with_id() async {
        
        let sortedMovies = sut.sort({$0.id}, mockMovies)
        
        for index in 0...sortedMovies.count - 1 {
            guard sortedMovies.indices.contains(index + 1) else {return}
            let isBiggerThanNext = sortedMovies[index].id > sortedMovies[index + 1].id
            XCTAssertTrue(isBiggerThanNext)
        }
    }

    func getMockMovies() {
        let response: AnyPublisher<MovieResponse, Error> = mockService.fetch(url: EndPoints.popular, page: nil)
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
