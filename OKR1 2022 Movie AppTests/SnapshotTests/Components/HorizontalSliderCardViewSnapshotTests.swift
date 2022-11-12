//
//  HorizontalSliderCardViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 12.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class HorizontalSliderCardViewSnapshotTests: XCTestCase {

    func test_horizontal_slider_card_view() {
        let cardView = HorizontalSliderCardView(nameAndId: ("Test Card", 0))
        let view: UIView = UIHostingController(rootView: cardView).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
}
