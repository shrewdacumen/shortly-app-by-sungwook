//
//  DEBUG_print.swift
//  shortly-app-swiftui-fmlzpw
//
//  Created by sungwook on 9/13/21.
//

import Foundation


/// The convenience debugging print() function that will be removed on the release state of the app.
public func DEBUG_print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
  
  #if DEBUG
  print(items, separator: separator, terminator: terminator)
  #endif
  
}
