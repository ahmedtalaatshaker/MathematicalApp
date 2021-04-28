//
//  MathematicalAppUITests.swift
//  MathematicalAppUITests
//
//  Created by ahmed talaat on 27/04/2021.
//

import XCTest

class MathematicalAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let equationHereTextField = app.textFields["Equation Here"]
        let key1 = app.keyboards.keys["1"]
        let key2 = app.keyboards.keys["2"]
        let key3 = app.keyboards.keys["3"]
        let key4 = app.keyboards.keys["4"]
        let key5 = app.keyboards.keys["5"]
        let key6 = app.keyboards.keys["6"]
        let key7 = app.keyboards.keys["7"]
        let key_ = app.keyboards.keys["-"]


        let calculateStaticText = app.buttons["Calculate"].staticTexts["Calculate"]
        let dalayTextField = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element(boundBy: 1)
        
        let hideKeyboard = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element

        

        equationHereTextField.tap()
        key1.tap()
        key2.tap()
        key_.tap()
        
        dalayTextField.tap()
        key6.tap()
        
        hideKeyboard.tap()
        calculateStaticText.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
