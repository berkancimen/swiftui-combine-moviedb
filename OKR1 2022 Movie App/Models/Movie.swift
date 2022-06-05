//
//  Movie.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 23.04.2022.
//

import Foundation

enum Ratings: String, SegmentBindable {
    
    case none = "All"
    case belowFive = "<5"
    case betweenFiveAndSeven = "5-7"
    case aboveSeven = ">7"
    var description: String { "\(self.rawValue)" }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    
    var title: String
    var id: Int
    var genre_ids: [Int]
    var vote_average: Double
    var poster_path: String
    var overview: String?
    var release_date: String?
}

struct MovieViewModel {
    
    let movie: Movie
    
    var name: String {
        movie.title
    }
    
    var id: Int {
        movie.id
    }
    
    var ratingEnum: Ratings {
        let rating = movie.vote_average
        if rating >= 0.0, rating < 5.0 {
           return .belowFive
        } else if rating >= 5.0, rating <= 7.0 {
           return .betweenFiveAndSeven
        } else if rating > 7.0, rating <= 10.0 {
           return .aboveSeven
        } else {
           return Ratings.none
        }
    }
    
    var rating: Double {
        movie.vote_average
    }
    
    var ratingString: String {
        return String(format: "%.1f", movie.vote_average)
    }
    
    var imageUrl: String {
        return "https://image.tmdb.org/t/p/w500" + movie.poster_path
    }
    
    var overview: String {
        movie.overview ?? ""
    }
    
    var genres: [Int] {
        movie.genre_ids
    }
    
    var releaseDate: String {
        movie.release_date ?? ""
    }
    
    static var `default`: MovieViewModel {
        let movie = Movie(title: "Movie 1", id: 0, genre_ids: [], vote_average: 2.3, poster_path: "/74xTEgt7R36Fpooo50r9T25onhq.jpg", overview: "Description")
        return MovieViewModel(movie: movie)
    }
}
