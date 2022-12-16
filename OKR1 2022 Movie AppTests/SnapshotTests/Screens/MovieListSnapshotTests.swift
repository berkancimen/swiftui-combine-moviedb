//
//  MovieListSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 13.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class MovieListSnapshotTests: XCTestCase {

    func test_movie_list_view() {
        let movieListView = MovieList(service: MockWebService(), screenName: .popular)
        movieListView.fetchMovieList()
        let viewController: UIViewController = UIHostingController(rootView: movieListView)
        assertSnapshot(
            matching: viewController,
            as: .image(on: .iPhoneXsMax(.portrait)))
    }
}
