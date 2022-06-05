//
//  SortingHelper.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 4.05.2022.
//

import Foundation

protocol Sort {
    
    associatedtype Item
    func sort<Spec: Comparable>(_ property: (Item) -> Spec, _ items: [Item]) -> [Item]
}

class MovieSort: Sort {
    
    typealias Item = MovieViewModel
   
    func sort<Spec>(_ property: (MovieViewModel) -> Spec, _ items: [MovieViewModel]) -> [MovieViewModel] where Spec : Comparable {
        return items.sorted(by: {property($0) > property($1)})
    }
    
}
