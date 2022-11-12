//
//  SegmentedViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 12.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class SegmentedViewSnapshotTests: XCTestCase {

    func test_segmented_view_date_selected() {
        let segmentedView = SegmentedView(.constant(SortType.date), title: "Sorting:")
        let view: UIView = UIHostingController(rootView: segmentedView).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
    
    func test_segmented_view_rating_selected() {
        let segmentedView = SegmentedView(.constant(SortType.rating), title: "Sorting:")
        let view: UIView = UIHostingController(rootView: segmentedView).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
}
