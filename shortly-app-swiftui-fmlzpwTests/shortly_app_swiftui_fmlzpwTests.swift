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
  
  
  
  
}
