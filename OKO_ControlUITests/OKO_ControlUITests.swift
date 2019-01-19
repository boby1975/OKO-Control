//
//  OKO_ControlUITests.swift
//  OKO_ControlUITests
//
//  Created by iMAC on 1/19/19.
//  Copyright © 2019 OKO. All rights reserved.
//

import XCTest

class OKO_ControlUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        app = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEditDoneSwitch() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let objectsNavigationBar = app.navigationBars["Objects"]
        
        // given
        let editButton = objectsNavigationBar.buttons["Edit"]
        let doneButton = objectsNavigationBar.buttons["Done"]
        
        // then
        if editButton.exists {
            XCTAssertFalse(doneButton.exists)
            editButton.tap()
            XCTAssertFalse(editButton.exists)
            XCTAssertTrue(doneButton.exists)
            doneButton.tap()
            XCTAssertTrue(editButton.exists)
            XCTAssertFalse(doneButton.exists)
        }else{
            XCTAssertFalse(editButton.exists)
            doneButton.tap()
            XCTAssertTrue(editButton.exists)
            XCTAssertFalse(doneButton.exists)
            editButton.tap()
            XCTAssertFalse(editButton.exists)
            XCTAssertTrue(doneButton.exists)
        }
        
    }

}
