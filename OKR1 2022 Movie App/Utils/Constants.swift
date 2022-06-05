//
//  Constants.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import Foundation

enum EndPoints {
    
    case genre
    case popular
    case trending
    case topRated
    
    func url(page: Int? = nil) -> String {
        
        var baseUrl: String { return "https://api.themoviedb.org/3"}
        var apiToken: String {return "?api_key=f74b7953c0527670d96035f6abfaca67"}
        var paging: String {return page == nil ? "" : "&page=\(page ?? 1)"}
        
        switch self {
        case .genre:
            return "\(baseUrl)/genre/movie/list" + apiToken
        case .popular:
            return "\(baseUrl)/movie/popular" + apiToken + paging
        case .trending:
            return "\(baseUrl)/trending/movie/week" + apiToken
        case .topRated:
            return "\(baseUrl)/movie/top_rated" + apiToken + paging
        }
    }
}
