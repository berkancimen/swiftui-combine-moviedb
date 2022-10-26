//
//  MovieListViewModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 4.06.2022.
//

import Foundation
import Combine

class MovieListViewModel : ObservableObject {
    
    private var movies: [MovieViewModel] = []
    @Published var filteredMovies: [MovieViewModel] = []
    @Published var screenName: String = ""
        
    private var service: NetworkServiceProtocol
    private var endPoint: EndPoints
    private var pageNumber: Int = 1
    private var cancellables = Set<AnyCancellable>()
    lazy private var movieService: MovieListServiceProtocol = {
        let client = MovieServices(service: service)
        return client
    }()
    
    lazy var movieFilter = MovieFilter()
    lazy var sorting = MovieSort()
    
    var filterOptions: (Ratings?, SortType?) = (nil, nil)
    
    init(service: NetworkServiceProtocol, screenName: ScreenNames) {
        self.service = service
        self.endPoint = screenName.getEndPoint()
        self.screenName = screenName.getScreenName()
    }
    
    func getMovies() {
        movieService.getMovies(cancallebles: &cancellables, endPoint: endPoint, page: pageNumber) { result in
            switch result {
            case .success((let movies)):
                self.movies.append(contentsOf: movies)
                self.filteredMovies.append(contentsOf: movies)
                self.filterMovie(rating: self.filterOptions.0, sort: nil)
                self.pageNumber += 1
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func shouldLoadMore(movie : MovieViewModel) {
        if let lastId = filteredMovies.last?.id, movie.id == lastId {
            Task {
                getMovies()
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
            filterOptions.0 = Ratings.none
        }
        
        if let sort = sort {
            switch sort {
            case .date:
                filteredMovies = sorting.sort({$0.releaseDate}, filteredMovies)
            case .rating:
                filteredMovies = sorting.sort({$0.rating}, filteredMovies)
            }
            filterOptions.1 = sort
        }
        
    }
    
    func getEndPoint() -> EndPoints {
        self.endPoint
    }
    
    func setEndPoint(endPoint: EndPoints) {
        self.endPoint = endPoint
    }
}
