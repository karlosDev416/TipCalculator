//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by Karlos Aguirre Zaragoza on 02/03/23.
//

import XCTest

final class when_content_view_is_shown: XCTestCase {
    
    private var app:XCUIApplication!
    private var contentViewPage:ContentViewPage!
    
    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        contentViewPage = nil
    }
    
    func test_should_make_sure_that_the_total_textfield_contains_default_value() {
        XCTAssertEqual(contentViewPage.totalTextField.value as! String, "Enter total")
    }
    
    func test_should_make_sure_the_20_percent_default_tip_option_is_selected() {
        let segmentedControlButton = contentViewPage.tipPercentageSegmentedControl.buttons.element(boundBy: 1)
        XCTAssertEqual(segmentedControlButton.label, "20%")
        XCTAssertTrue(segmentedControlButton.isSelected)
    }
}

final class when_calculate_tip_button_is_pressed_for_valid_input:XCTestCase {

    private var app:XCUIApplication!
    private var contentViewPage:ContentViewPage!

    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
                
        contentViewPage.totalTextField.tap()
        contentViewPage.totalTextField.typeText("100")
        contentViewPage.calculateTipButton.tap()
    }
    
    override func tearDown() {
        app = nil
        contentViewPage = nil
    }

    func test_should_make_sure_that_tip_is_displayed_on_the_screen() {
        let _ = contentViewPage.tipText.waitForExistence(timeout: 1.5)
        XCTAssertEqual(contentViewPage.tipText.label, "$20.00")
    }
}

final class when_calculate_tip_button_is_pressed_for_invalid_input:XCTestCase {
    
    private var app:XCUIApplication!
    private var contentViewPage:ContentViewPage!

    override func setUp() {
        app = XCUIApplication()
        contentViewPage = ContentViewPage(app: app)
        continueAfterFailure = false
        app.launch()
                
        contentViewPage.totalTextField.tap()
        contentViewPage.totalTextField.typeText("-100")
        contentViewPage.calculateTipButton.tap()
    }
    
    override func tearDown() {
        app = nil
        contentViewPage = nil
    }
    
    func test_should_clear_tip_label_for_invalid_input() {
        let _ = contentViewPage.tipText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(contentViewPage.tipText.label, "")
    }
    
    func test_should_display_error_message_for_invalid_input() {
        let _ = contentViewPage.messageText.waitForExistence(timeout: 0.5)
        XCTAssertEqual(contentViewPage.messageText.label, "Invalid Input")
        
    }
}
