//
//  NetworkManager.swift
//  OKR1 2022 Movie App
//
//  Created by Cimen, Berkan on 22.10.2022.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var service: NetworkServiceProtocol = {
        var isRunningTests: Bool {
            return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
        }
        return isRunningTests ? MockWebService() : Webservice()
    }()
}
