//
//  SearchViewModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 9.06.2022.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    
    private var movies: [MovieViewModel] = []
    @Published var filteredMovies: [MovieViewModel] = []
    @Published var activityIndAnimating: Bool = false
    
    private var searchText: String = ""
    
    private var service: NetworkService
    private var pageNumber: Int = 1
    
    let movieFilter = MovieFilter()
    let sorting = MovieSort()
    
    private var task: Task<Void, Never>?
    
    var filterOptions: (Ratings?, SortType?) = (nil, nil)
    
    init(service: NetworkService) {
        self.service = service
    }
    
//    func getMovies(searchText: String) async {
//        self.searchText = searchText
//        do {
//            let response: MovieResponse = try await service.fetch(url: EndPoints.search(searchText), page: pageNumber)
//            let items = response.results
//            DispatchQueue.main.async {
//                self.movies.append(contentsOf: items.map(MovieViewModel.init))
//                self.filteredMovies.append(contentsOf: items.map(MovieViewModel.init))
//                self.filterMovie(rating: self.filterOptions.0, sort: nil)
//            }
//            self.pageNumber += 1
//        } catch {
//            print(error)
//        }
//    }
    
    func shouldLoadMore(movie : MovieViewModel) {
        if let lastId = filteredMovies.last?.id, movie.id == lastId {
            getMovies(searchText)
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
            return
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
            do {
                let response: MovieResponse = try await service.fetch(url: EndPoints.search(searchText.urlHostAllowedString()), page: pageNumber)
                let items = response.results
                DispatchQueue.main.async {
                    self.activityIndAnimating = false
                    self.movies.append(contentsOf: items.map(MovieViewModel.init))
                    self.filteredMovies.append(contentsOf: items.map(MovieViewModel.init))
                    self.filterMovie(rating: self.filterOptions.0, sort: nil)
                }
                self.pageNumber += 1
            } catch {
                activityIndAnimating = false
                print(error)
            }
        }
    }
}
