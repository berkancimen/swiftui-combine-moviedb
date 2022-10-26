//
//  NetworkMovieService.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 22.10.2022.
//

import Foundation
import Combine

// MARK: - Movie Services -
class MovieServices {
    
    var service: NetworkServiceProtocol
    
    required init(service: NetworkServiceProtocol) {
        self.service = service
    }
}


