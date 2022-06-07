//
//  WebServiceFactory.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 26.04.2022.
//

import Foundation

class WebServiceFactory {
    
    static func create() -> NetworkService {
        
        let environment = ProcessInfo.processInfo.environment["ENV"]
        if let environment = environment, environment == "TEST" {
            return MockWebService()
        } else if Thread.current.isRunningXCTest {
            return MockWebService()
        } else {
            return Webservice()
        }
    }
    
}
