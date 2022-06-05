//
//  FilterHelper.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 23.04.2022.
//

import Foundation

protocol Filter {
    
    associatedtype Item
    func filter<Spec: Specification>(_ items: [Item], _ spec: Spec) -> [Item]
    where Spec.Item == Item;
}

class MovieFilter : Filter {
    
    typealias T = MovieViewModel
    
    func filter<Spec: Specification>(_ items: [MovieViewModel], _ spec: Spec)
    -> [T] where Spec.Item == T {
        var movies = [MovieViewModel]()
        for movie in items {
            if spec.isSatisfied(movie) {
                movies.append(movie)
            }
        }
        return movies
    }
}

