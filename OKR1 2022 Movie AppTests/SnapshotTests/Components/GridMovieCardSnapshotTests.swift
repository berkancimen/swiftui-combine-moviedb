//
//  GridMovieCardSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 12.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class GridMovieCardSnapshotTests: XCTestCase {

    func test_grid_movie_card_view() {
        let cardView = GridMovieCardView(movie: MovieViewModel.default, cardColor: .red)
        let view: UIView = UIHostingController(rootView: cardView).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
}
