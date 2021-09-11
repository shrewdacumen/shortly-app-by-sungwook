//
//  shortly_app_swiftui_fmlzpwUITests.swift
//  shortly-app-swiftui-fmlzpwUITests
//
//  Created by sungwook on 9/2/21.
//

import XCTest


// MARK: symbol used: XCT_UITEST

class shortly_app_swiftui_fmlzpwUITests: XCTestCase {
  
  private var app: XCUIApplication!
  
  override func setUp() {
    
    super.setUp()
    
    self.app = XCUIApplication()
    self.app.launch()
  }
  
  
  func testLaunchPerformance() throws {
    if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
      // This measures how long it takes to launch your application.
      measure(metrics: [XCTApplicationLaunchMetric()]) {
        XCUIApplication().launch()
      }
    }
  }
  
  /// ** CAVEAT **
  /// XCT_UITEST should be added to the compile to test the following
  func test_add_invalid_url_andThen_check_if_there_is() {
    
    XCTExpectFailure("This test should be done with XCT_UITEST symbol & at the beginning of UI development.")
    XCTExpectFailure("Otherwise, this function will be seen as an error which is false.")
    
    let the_only_textField = self.app.textFields["textField url_string"]
    
    the_only_textField.tap()
    the_only_textField.typeText("Sun/g/W.net")
    
    let rowCount = self.app.tables.children(matching: .cell).count
    
    XCTAssertEqual(rowCount, 0)

  }
  
  /// ** CAVEAT **
  /// XCT_UITEST should be added to the compile to test the following
  func test_add_valid_url_andThen_check_if_there_is() {
    
    XCTExpectFailure("This test should be done with XCT_UITEST symbol & at the beginning of UI development.")
    XCTExpectFailure("Otherwise, this function will be seen as an error which is false.")
    
    let the_only_textField = self.app.textFields["textField url_string"]
    
    
    the_only_textField.tap()
    the_only_textField.typeText("SungW.net")
    
    let rowCount = self.app.tables.children(matching: .cell).count
    
    XCTAssertEqual(rowCount, 1)
  }
  
  /// This test taking too long time -> better to test this in manual.
  func test_tap_the_button_activate_those_URLSessions() {
    
    let the_button_for_processing_url_string = self.app.buttons["button url_string"]
    
    /// I have to wait
    /// 18 sec more before the testing
    /// according to os.signpost logging test.
    ///    see ReadMe.md for more information.
    
    print("""
This test can not be done automatically but manually.
Therefore, it is why I stopped utilizing this function.
""")
     
    _ = the_button_for_processing_url_string
  }
  

}
