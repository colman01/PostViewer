//
//  PostViewerUITests.swift
//  PostViewerUITests
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import XCTest

class PostViewerUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApp() {

        
        let app = XCUIApplication()
        app.launch()
        app.textFields.element(boundBy: 0).tap()
        app.textFields.element(boundBy: 0).typeText("Bob")
        app.buttons["LOGIN"].tap()
        
        let tablesQuery = app.tables
        let tabBarsQuery = app.tabBars
        let favPosts = tabBarsQuery.buttons["Fav Posts"]
        let posts = tabBarsQuery.buttons["Posts"]
        let backBtn = app.navigationBars.element(boundBy: 0).buttons["Back"]
        
        XCTAssert(tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["first post with another change"]/*[[".cells.staticTexts[\"first post with another change\"]",".staticTexts[\"first post with another change\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.waitForExistence(timeout: 10))
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["first post with another change"]/*[[".cells.staticTexts[\"first post with another change\"]",".staticTexts[\"first post with another change\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        backBtn.tap()
        
        XCTAssert(tablesQuery.children(matching: .cell).element(boundBy: 1).staticTexts["second post body text"].waitForExistence(timeout: 10))
        tablesQuery.children(matching: .cell).element(boundBy: 1).staticTexts["second post body text"].tap()
        
        backBtn.tap()
        
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 2)
        XCTAssert(cell.staticTexts[" post body text"].waitForExistence(timeout: 10))
        
        favPosts.tap()
        posts.tap()
        cell.buttons["Fav"].tap()
        favPosts.tap()
        posts.tap()
        
        app.navigationBars.element(boundBy: 0).buttons["Back"].tap()
        enterUserName("Al")
        XCTAssert(posts.waitForExistence(timeout: 10))
        backBtn.tap()
        enterUserName("Alice")
        XCTAssert(posts.waitForExistence(timeout: 10))
        backBtn.tap()
        enterUserName("Tom")
        XCTAssert(posts.waitForExistence(timeout: 10))
        backBtn.tap()
        enterUserName("Alan")
        XCTAssert(app.alerts["Login Failed"].staticTexts["Login Failed"].waitForExistence(timeout: 10))
    
    }
    
    
    func testSwipe() {
        let app = XCUIApplication()
        app.launch()
        app.textFields.element(boundBy: 0).tap()
        app.textFields.element(boundBy: 0).typeText("Bob")
        app.buttons["LOGIN"].tap()
        let tablesQuery = app.tables
        XCTAssert(tablesQuery.staticTexts["first post with another change"].waitForExistence(timeout: 10))
        tablesQuery.staticTexts["first post with another change"].gentleSwipe(.up)
    }
    
    
    func enterUserName(_ name : String) {
        let app = XCUIApplication()
        app.launch()
        app.textFields.element(boundBy: 0).tap()
        app.textFields.element(boundBy: 0).typeText(name)
        app.buttons["LOGIN"].tap()
    }

    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement {
    enum Direction: Int {
        case up, down, left, right
    }

    func gentleSwipe(_ direction: Direction) {
        let half: CGFloat = 0.5
        let adjustment: CGFloat = 8.25
        let pressDuration: TimeInterval = 0.05

        let lessThanHalf = half - adjustment
        let moreThanHalf = half + adjustment

        let centre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))
        let aboveCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: lessThanHalf))
        let belowCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))
        let leftOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: lessThanHalf, dy: half))
        let rightOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: moreThanHalf, dy: half))

        switch direction {
        case .up:
            centre.press(forDuration: pressDuration, thenDragTo: aboveCentre)
        case .down:
            centre.press(forDuration: pressDuration, thenDragTo: belowCentre)
        case .left:
            centre.press(forDuration: pressDuration, thenDragTo: leftOfCentre)
        case .right:
            centre.press(forDuration: pressDuration, thenDragTo: rightOfCentre)
        }
    }
}


