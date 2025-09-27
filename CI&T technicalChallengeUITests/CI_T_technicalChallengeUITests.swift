//
//  CI_T_technicalChallengeUITests.swift
//  CI&T technicalChallengeUITests
//
//  Created by Sérgio César Lira Júnior on 24/09/25.
//

import XCTest

final class CI_T_technicalChallengeUITests: XCTestCase {

    var sut: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        sut = XCUIApplication()
        sut.launchArguments = ["UITest", "1"]
        sut.launch()

    }

    override func tearDownWithError() throws {
        sut = nil
    }

    @MainActor
    func testOpenPokemon() throws {
        XCTAssertTrue(sut.otherElements["mainContent"].waitForExistence(timeout: 5))
        sut.buttons["goToDetailPokemon Bulbasaur"].tap()
        XCTAssertTrue(sut.staticTexts["Bulbasaur"].waitForExistence(timeout: 5))
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
