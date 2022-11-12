//
//  CustomButtonViewSnapshotTests.swift
//  OKR1 2022 Movie AppTests
//
//  Created by Cimen, Berkan on 12.11.2022.
//

import XCTest
@testable import OKR1_2022_Movie_App
import SwiftUI
import SnapshotTesting

final class CustomButtonViewSnapshotTests: XCTestCase {

    func test_custom_button_view_loading() {
        let button = CustomButtonView(completion: nil, title: "Test Button", backgroundColor: .blue, cornerRadius: 12, isAnimating: .constant(true))
        let view: UIView = UIHostingController(rootView: button).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
    
    func test_custom_button_view_not_loading() {
        let button = CustomButtonView(completion: nil, title: "Test Button", backgroundColor: .blue, cornerRadius: 12, isAnimating: .constant(false))
        let view: UIView = UIHostingController(rootView: button).view
        assertSnapshot(
          matching: view,
          as: .image(size: view.intrinsicContentSize))
    }
}
