//
//  MovieListViewModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 4.06.2022.
//

import Foundation

class MovieListViewModel : ObservableObject {
    
    private var movies: [MovieViewModel] = []
    @Published var filteredMovies: [MovieViewModel] = []
    @Published var screenName: String = "Movie Detail"
    
    private var service: NetworkService
    private var endPoint: EndPoints
    private var pageNumber: Int = 1
    
    let movieFilter = MovieFilter()
    let sorting = MovieSort()
    
    var filterOptions: (Ratings?, SortType?) = (nil, nil)
    
    init(service: NetworkService, screenName: ScreenNames) {
        self.service = service
        self.endPoint = screenName.getEndPoint()
        self.screenName = screenName.getScreenName()
    }
    
    func getMovies() async {
        do {
            let response: MovieResponse = try await service.fetch(url: self.endPoint, page: pageNumber)
            let items = response.results
            DispatchQueue.main.async {
                self.movies.append(contentsOf: items.map(MovieViewModel.init))
                self.filteredMovies.append(contentsOf: items.map(MovieViewModel.init))
                self.filterMovie(rating: self.filterOptions.0, sort: nil)
            }
            self.pageNumber += 1
        } catch {
            print(error)
        }
    }
    
    func shouldLoadMore(movie : MovieViewModel) {
        if let lastId = filteredMovies.last?.id, movie.id == lastId {
            Task {
                await getMovies()
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
