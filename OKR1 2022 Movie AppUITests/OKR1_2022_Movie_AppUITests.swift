//
//  OKR1_2022_Movie_AppUITests.swift
//  OKR1 2022 Movie AppUITests
//
//  Created by Cimen, Berkan on 25.06.2022.
//

import XCTest

class OKR1_2022_Movie_AppUITests: XCTestCase {
    
    var app: XCUIApplication = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    func test_tabbar_seelections() {
        
        // Search Tab
        app.tabBars.firstMatch.buttons.element(boundBy: 1).tap()
        
        // Home Tab
        app.tabBars.firstMatch.buttons.element(boundBy: 0).tap()
    }
    
}
