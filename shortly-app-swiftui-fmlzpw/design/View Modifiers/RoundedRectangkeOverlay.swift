//
//  RoundedRectangkeOverlay.swift
//  RoundedRectangkeOverlay
//
//  Created by sungwook on 9/7/21.
//

import SwiftUI


// TODO: incomplete. Why is this causing a threading error to SwiftUI?

// MARK: Not in use

/// instead of `.textFieldStyle(RoundedBorderTextFieldStyle())`
/// instead of `.buttonStyle()`
/// use this modifier over SwiftUI view like TextField, Button/
struct RoundedRectangkeOverlay: ViewModifier {
  
  let strokeColor: Color
  
  func body(content: Content) -> some View {
    
    content.overlay(
      RoundedRectangle(cornerRadius: 5)
              .stroke(strokeColor, lineWidth: TheGlobalUIParameter.overlay_width_for_rounded_border)
             )
  }
}


extension View {
  
  func roundedRectangleOveray(strokeColor: Color) -> some View {
    
    modifier(RoundedRectangkeOverlay(strokeColor: strokeColor))
  }
}

