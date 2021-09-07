//
//  ConditionalTextFieldOverlayModifier.swift
//  ConditionalTextFieldOverlayModifier
//
//  Created by sungwook on 9/5/21.
//

import SwiftUI


/// This is designed for displaying the error message over the text field/
struct ConditionalTextFieldOverlayModifier: ViewModifier {
  
  let condition: InputFieldError_Enum
  
  func body(content: Content) -> some View {
    
    if condition == .emptyString {

      content.overlay(Text("Please add a link here")
                        .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
                        .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue)))
        .border(Color(hex_string: ColorEnum.secondary_red.rawValue) ?? Color.red, width: 3)
      
    } else if condition == .invalidUrl {
      
      content.overlay(Text("Please enter a correct URL")
                        .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
                        .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue)))
        .border(Color(hex_string: ColorEnum.secondary_red.rawValue) ?? Color.red, width: 3)
    
    } else if condition == .duplicated {
      
      content.overlay(Text("It is a duplicate")
                        .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
                        .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue)))
        .border(Color(hex_string: ColorEnum.secondary_red.rawValue) ?? Color.red, width: 3)
      
      } else {
      
      content
    }
    
  }
}


extension View {
  
  func conditionalOverlay(condition: InputFieldError_Enum) -> some View {
    
    modifier(ConditionalTextFieldOverlayModifier(condition: condition))
  }
}
