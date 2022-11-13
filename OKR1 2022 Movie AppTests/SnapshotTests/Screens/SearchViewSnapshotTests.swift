//
//  SearchViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 13.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class SearchViewSnapshotTests: XCTestCase {

    func test_search_view() {
        let searchView = SearchView(service: MockWebService())
        let viewController: UIViewController = UIHostingController(rootView: searchView)
        assertSnapshot(
            matching: viewController,
            as: .image(on: .iPhoneXsMax(.portrait)))
    }
}
