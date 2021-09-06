//
//  DebuggingBorderModifier.swift
//  DebuggingBorderModifier
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI



struct DebuggingBorderModifier: ViewModifier {
  
  func body(content: Content) -> some View {
    
    if TheGlobalUIParameter.is_debugging_mode {
    
    content.border(Color.blue, width: 5)
    
    } else {
      
      content
    }
    
  }
}


extension View {
  
  func debuggingBorder() -> some View {
    
    modifier(DebuggingBorderModifier())
  }
}
