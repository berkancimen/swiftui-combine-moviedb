//
//  HorizontalMoviewSliderViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 12.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class HorizontalMovieSliderViewSnapshotTests: XCTestCase {

    func test_horizontal_movie_slider_single_movie() {
        let sliderView = HorizontalMovieSliderView(movies: .constant([MovieViewModel.default]), sliderType: .popular)
        let view: UIView = UIHostingController(rootView: sliderView).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
    
    func test_horizontal_movie_slider_multiple_movies() {
        let sliderView = HorizontalMovieSliderView(movies: .constant([MovieViewModel.default, MovieViewModel.default, MovieViewModel.default]), sliderType: .popular)
        let view: UIView = UIHostingController(rootView: sliderView).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
    
    

}
