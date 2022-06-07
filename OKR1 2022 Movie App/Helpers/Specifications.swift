//
//  GenreSpecification.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 23.04.2022.
//

import Foundation

protocol Specification {
    
    associatedtype Item
    func isSatisfied(_ item: Item) -> Bool
}

// MARK: - Genre Spec -
class MovieGenreSpecification: Specification {
    
    typealias Item = MovieViewModel
    let genre: GenresViewModel
    
    init(_ genre: GenresViewModel) {
        self.genre = genre
    }
    
    func isSatisfied(_ item: MovieViewModel) -> Bool {
        return item.genres.contains(genre.genreId)
    }
}

// MARK: - Rating Spec -
class MovieRatingSpecification: Specification {
    
    typealias Item = MovieViewModel
    let ratingEnum: Ratings
    
    init(ratingEnum: Ratings) {
        self.ratingEnum = ratingEnum
    }
    
    func isSatisfied(_ item: MovieViewModel) -> Bool {
        return item.ratingEnum == ratingEnum
    }
}

class AndSpecification<T, SpecA: Specification, SpecB: Specification> : Specification
where SpecA.Item == SpecB.Item, T == SpecA.Item {
    
    let first: SpecA
    let second: SpecB
    
    init(_ first: SpecA, _ second: SpecB) {
        self.first = first
        self.second = second
    }
    
    func isSatisfied(_ item: T) -> Bool {
        return first.isSatisfied(item) && second.isSatisfied(item)
    }
}

