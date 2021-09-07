//
//  AdaptivePaddingOverAllDevices.swift
//  AdaptivePaddingOverAllDevices
//
//  Created by sungwook on 9/7/21.
//

import SwiftUI

///  ** CAVEAT **
/// - hasNotch property was introduced to adapt the UI interfaces and elements over various iOS devices.
///   What I found was as the followings:
///     - iOS devices that have a notch have safeAreaInsets.top != 0,
///     -  but iOS devices that have a notch have safeAreaInsets.top == 0,
///     Therefore, the behavior of each UI element and animation to it will be affected accordingly.


struct AdaptivePaddingOverAllDevices: ViewModifier {
  
  let hasNotch: Bool
  
  func body(content: Content) -> some View {
    
    content.padding(.top, hasNotch ? 40:10)
  }
}

extension View {
  
  func adaptivePaddingOverAllDevices(hasNotch: Bool) -> some View {
    
    modifier(AdaptivePaddingOverAllDevices(hasNotch: hasNotch))
  }
}

