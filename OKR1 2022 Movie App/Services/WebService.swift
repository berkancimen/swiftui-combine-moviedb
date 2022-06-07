//
//  WebService.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import Foundation

protocol NetworkService {
    
    func fetch<T: Decodable>(url: EndPoints, page: Int?) async throws -> T
}

class Webservice: NetworkService {
    
    func fetch<T: Decodable>(url: EndPoints, page: Int? = nil) async throws -> T {
        
        let urlString = url.url(page: page)
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "No URL", code: 0, userInfo: [:])
            throw error
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
