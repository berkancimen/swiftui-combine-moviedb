//
//  HomeHeaderViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 12.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class HomeHeaderViewSnapshotTests: XCTestCase {

    func test_home_header_view() {
        let headerView = HomeHeaderView(title: "Test Header")
        let view: UIView = UIHostingController(rootView: headerView).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
}
