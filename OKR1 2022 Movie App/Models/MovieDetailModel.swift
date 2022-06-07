//
//  MovieDetailModel.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 5.06.2022.
//

import Foundation

// MARK: - MovieDetailModel
class MovieDetailModel: Decodable {
    var adult: Bool?
    var backdrop_path: String?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var original_language, original_title, overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: [ProductionCompany]?
    var release_date: String?
    var revenue: Int?
    var status, tagline, title: String?
    var vote_average: Double?
    var vote_count: Int?
    var runtime: Int?
}

// MARK: - ProductionCompany
class ProductionCompany: Decodable {
    var id: Int?
    var logoPath, name, originCountry: String?

}

struct MovieDetailModelViewModel {
    
    let movie: MovieDetailModel
    
    var name: String {
        movie.title ?? ""
    }
    
    var id: Int {
        movie.id ?? 0
    }
    
    var ratingEnum: Ratings {
        guard let rating = movie.vote_average else {return Ratings.none}
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
        movie.vote_average ?? 0.0
    }
    
    var ratingString: String {
        return String(format: "%.1f", movie.vote_average ?? 0.0)
    }
    
    var imageUrl: String {
        return "https://image.tmdb.org/t/p/w500" + (movie.poster_path ?? "")
    }
    
    var overview: String {
        movie.overview ?? ""
    }
    
    var genres: [Genre]? {
        movie.genres
    }
    
    var releaseDate: String {
        movie.release_date ?? ""
    }
    
    var originalLanguage: String? {
        movie.original_language
    }
    
    var revenue: String {
        guard let revenue = movie.revenue as NSNumber?, revenue != 0 else {return "N/A"}
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: revenue) ?? "N/A"
    }
    
    var duration: String {
        "\(movie.runtime ?? 0) minutes"
    }
    
    static var `default`: MovieDetailModelViewModel {
        let movie = MovieDetailModel()
        return MovieDetailModelViewModel(movie: movie)
    }
    
}
    
    
