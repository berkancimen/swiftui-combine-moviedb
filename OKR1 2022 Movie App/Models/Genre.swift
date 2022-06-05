//
//  Genre.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 23.04.2022.
//

import Foundation

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let name: String
    let id: Int
}

struct GenresViewModel {
    
    let genre: Genre
    
    var genreName: String {
        genre.name
    }
    
    var genreId: Int {
        genre.id
    }
    
    static var `default`: GenresViewModel {
        let genre = Genre(name: "Action", id: 1)
        return GenresViewModel(genre: genre)
    }
   
}
