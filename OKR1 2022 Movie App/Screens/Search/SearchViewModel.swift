//
//  SearchViewModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 9.06.2022.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    private var movies: [MovieViewModel] = []
    @Published var filteredMovies: [MovieViewModel] = []
    @Published var activityIndAnimating: Bool = false
    
    private var searchText: String = ""
    
    private var service: NetworkService
    private var pageNumber: Int = 1
    
    private var cancellable: AnyCancellable?
    
    let movieFilter = MovieFilter()
    let sorting = MovieSort()
    
    private var task: Task<Void, Never>?
    
    var filterOptions: (Ratings?, SortType?) = (nil, nil)
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func shouldLoadMore(movie : MovieViewModel) {
        if let lastId = filteredMovies.last?.id, movie.id == lastId {
            Task {
               getMovies(searchText)
            }
        }
        return
    }
    
    func filterMovie(rating: Ratings? = Ratings.none, sort: SortType? = nil) {
        
        if let rating = rating, rating != .none {
            filteredMovies = movieFilter.filter(movies, MovieRatingSpecification(ratingEnum: rating))
            filterOptions.0 = rating
        } else {
            filteredMovies = movies
        }
        
        if let sort = sort {
            filteredMovies = sorting.sort({$0.rating}, filteredMovies)
            filterOptions.1 = sort
        }
        
    }
    
    func getMovies(_ text: String) {
        if self.searchText == text {
            task?.cancel()
            activityIndAnimating = false
        } else {
            activityIndAnimating = true
            pageNumber = 1
            movies = []
            filteredMovies = []
            self.searchText = text
        }
        guard !text.isEmpty else {
            movies = []
            filteredMovies = []
            task?.cancel()
            activityIndAnimating = false
            return
        }
        
        task?.cancel()
        task = Task {
            guard !Task.isCancelled else {
                activityIndAnimating = false
                return
            }
            self.searchText = text
            let response = service.fetch(type: MovieResponse.self, url: EndPoints.search(searchText.urlHostAllowedString()), page: pageNumber)
            cancellable = response
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.activityIndAnimating = false
                        print(error)
                    }
                }, receiveValue: { [weak self] in
                    self?.activityIndAnimating = false
                    self?.movies.append(contentsOf: $0.results.map(MovieViewModel.init))
                    self?.filteredMovies.append(contentsOf: $0.results.map(MovieViewModel.init))
                    self?.filterMovie(rating: self?.filterOptions.0, sort: nil)
                    self?.pageNumber += 1
                })
        }
    }
}
