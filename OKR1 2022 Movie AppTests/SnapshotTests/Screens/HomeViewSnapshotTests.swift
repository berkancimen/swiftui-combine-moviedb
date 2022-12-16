//
//  HomeViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 12.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class HomeViewSnapshotTests: XCTestCase {
    
    func test_home_view() {
        let homeView = HomeView(service: MockWebService())
        homeView.fetchPopularMovies()
        homeView.fetchTrendingMovies()
        homeView.fetchTopRatedMovies()
        let viewController: UIViewController = UIHostingController(rootView: homeView)
        assertSnapshot(
            matching: viewController,
            as: .image(on: .iPhone8(.portrait)))
    }
}
