//
//  MovieRamaUITests.swift
//  MovieRamaUITests
//
//  Created by Alex Moumoulidis on 4/12/23.
//

import XCTest

final class MovieRamaUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOpenCloseSearch() throws {
        let app = XCUIApplication()
        
        app.launch()
        
        
        let movieramaNavigationBar = XCUIApplication().navigationBars["MOVIERAMA!!!"]
        movieramaNavigationBar.searchFields["Search"].tap()
        movieramaNavigationBar.buttons["Cancel"].tap()
        
    }
    
    func testSearchAndFindSpecificMovie() throws {
        let app = XCUIApplication()
        
        app.launch()
        
        let movieramaNavigationBar = XCUIApplication().navigationBars["MOVIERAMA!!!"]
        movieramaNavigationBar.searchFields["Search"].tap()
        
        movieramaNavigationBar.searchFields["Search"].typeText("Oppenheimer")

        let description = app.staticTexts["Oppenheimer"]
        let exists = NSPredicate(format: "exists == 1")

        expectation(for: exists, evaluatedWith: description, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        
        let table = app.tables.element

        let cell = table.cells.element(boundBy: 0)
        
        let indexedText = cell.staticTexts["Oppenheimer"]

        expectation(for: exists, evaluatedWith: indexedText, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        
        
    }
    
    func testSearchAndFindSpecificMovieOpenDetailsAndThenClose() throws {
        let app = XCUIApplication()
        
        app.launch()
        
        let actualMovieTitle = "The Lord of the Rings: The Fellowship of the Ring"
        
        let searchQuery = "The Lord of The Rings"
        let exists = NSPredicate(format: "exists == 1")
        let doesNotExist = NSPredicate(format: "exists == 0")
        
        let movieramaNavigationBar = XCUIApplication().navigationBars["MOVIERAMA!!!"]
        movieramaNavigationBar.searchFields["Search"].tap()
        
        movieramaNavigationBar.searchFields["Search"].typeText(searchQuery)
        
        let cellTitle = app.staticTexts[actualMovieTitle]
        
        expectation(for: exists, evaluatedWith: cellTitle, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
        
        let table = app.tables.element

        let cell = table.cells.element(boundBy: 0)
        
        cell.tap()
        
        let directorExists = app.staticTexts["Peter Jackson"]

        expectation(for: exists, evaluatedWith: directorExists, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        expectation(for: doesNotExist, evaluatedWith: directorExists, handler: nil)
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertFalse(directorExists.exists)
        
        expectation(for: exists, evaluatedWith: cellTitle, handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    //Should have a test for favorite button here but per request of the assignment the ourcome is random so the test will be flaky...

}
