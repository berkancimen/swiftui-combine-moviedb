//
//  FilterViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 13.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class FilterViewSnapshotTests: XCTestCase {

    func test_filter_view() {
        let filterView = FilterView { _, _ in}
        let viewController: UIViewController = UIHostingController(rootView: filterView)
        assertSnapshot(
            matching: viewController,
            as: .image(on: .iPhoneXsMax(.portrait)))
    }
}
