//
//  IgnoreSafeArea_Unversal.swift
//  IgnoreSafeArea_Unversal
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI


struct IgnoreSafeArea_Unversal: ViewModifier {
  
  let hasNotch: Bool
  
  func body(content: Content) -> some View {
    
    
    if hasNotch {
      
      content.ignoresSafeArea()
      
    } else {
      
      content
    }
    
  }
}


extension View {
  
  func ignoreSafeAreaUniversal(hasNotch: Bool) -> some View {
    
    modifier(IgnoreSafeArea_Unversal(hasNotch: hasNotch))
  }
}
