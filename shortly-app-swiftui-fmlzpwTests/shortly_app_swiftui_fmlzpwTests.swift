//
//  shortly_app_swiftui_fmlzpwTests.swift
//  shortly-app-swiftui-fmlzpwTests
//
//  Created by sungwook on 9/2/21.
//

import XCTest
@testable import shortly_app_swiftui_fmlzpw

class shortly_app_swiftui_fmlzpwTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  func test_fonts() {
    
    var is_Poppins_included = false
    var count_Poppins_ThinItalic = 0
    
    var number_of_fonttypes_of_Poppins = 0
    
    UIFont.familyNames.forEach { font_family in
      

      
      if String(font_family.prefix(7)) == "Poppins" {
        
        is_Poppins_included = true
        
        number_of_fonttypes_of_Poppins = UIFont.fontNames(forFamilyName: font_family).count
      }
      
      for font_name in UIFont.fontNames(forFamilyName: font_family) {
        
        if font_name == "Poppins-ThinItalic" {
          
          count_Poppins_ThinItalic += 1
        }
      }
      
    }

    
    XCTAssertTrue(is_Poppins_included)
    
    XCTAssertEqual(count_Poppins_ThinItalic, 1)
    
    XCTAssertEqual(number_of_fonttypes_of_Poppins, 18)
  }
  
  
  /// #35323E Grayish Violet
  func test_Color35323E() {
    
    let rgbColor = rgbaValue(hex_string: "#35323E")
    
    XCTAssertNotNil(rgbColor)
    XCTAssertEqual(rgbColor!.r, 53.0/255.0)
    XCTAssertEqual(rgbColor!.g, 50.0/255.0)
    XCTAssertEqual(rgbColor!.b, 62.0/255.0)
    XCTAssertEqual(rgbColor!.a, 1.0)
        
  }
  
  ///  #232127 Very Dark Violet
  func test_Color232127() {
    
    let rgbColor = rgbaValue(hex_string: "#232127")
    
    XCTAssertNotNil(rgbColor)
    XCTAssertEqual(rgbColor!.r, 35.0/255.0)
    XCTAssertEqual(rgbColor!.g, 33.0/255.0)
    XCTAssertEqual(rgbColor!.b, 39.0/255.0)
    XCTAssertEqual(rgbColor!.a, 1.0)
  }
  
  func test_StringExtension_strict() {
    
    XCTAssertTrue("http://sungw.net".validateUrl())
    XCTAssertTrue("https://sungw.net".validateUrl())
    XCTAssertFalse("http://sungw_net".validateUrl())
    XCTAssertTrue("https://sungw.net/my-portfolio".validateUrl())
  }
  
  func test_StringExtension_userFriendly() {
    
    XCTAssertTrue("sungw.net".validateUrl())
    XCTAssertTrue("sungw.net/my-portfolio".validateUrl())
    XCTAssertTrue("sungw.net/my-portfolio/".validateUrl())
    XCTAssertTrue("https://sungw.net/".validateUrl())
    XCTAssertTrue("https://sungw.net/my-portfolio/".validateUrl())
  }
}
