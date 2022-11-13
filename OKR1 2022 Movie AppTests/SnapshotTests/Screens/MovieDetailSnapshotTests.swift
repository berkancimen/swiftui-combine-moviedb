//
//  MovieDetailSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 13.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class MovieDetailSnapshotTests: XCTestCase {
    
    func test_movie_detail_view() {
        let movieDetailView = MovieDetail(service: MockWebService(), movieId: 675353)
        let viewController: UIViewController = UIHostingController(rootView: movieDetailView)
        assertSnapshot(
            matching: viewController,
            as: .image(on: .iPhoneXsMax(.portrait)))
    }
}
