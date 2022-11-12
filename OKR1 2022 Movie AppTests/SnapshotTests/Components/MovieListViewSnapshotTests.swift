//
//  MovieListViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 12.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class MovieListViewSnapshotTests: XCTestCase {

    func test_movie_list_view_single_movie() {
        let movieListView = MovieListView(movies: .constant([MovieViewModel.default]))
        let viewController: UIViewController = UIHostingController(rootView: movieListView)
        assertSnapshot(
          matching: viewController,
          as: .image(on: .iPadPro11(.portrait)))
    }
    
    func test_movie_list_view_multiple_movies() {
        let movieListView = MovieListView(movies: .constant([MovieViewModel.default, MovieViewModel.default, MovieViewModel.default]))
        let viewController: UIViewController = UIHostingController(rootView: movieListView)
        assertSnapshot(
          matching: viewController,
          as: .image(on: .iPadPro11(.portrait)))
    }
}
