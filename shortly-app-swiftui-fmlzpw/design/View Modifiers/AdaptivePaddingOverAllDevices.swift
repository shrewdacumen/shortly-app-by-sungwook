//
//  AdaptivePaddingOverAllDevices.swift
//  AdaptivePaddingOverAllDevices
//
//  Created by sungwook on 9/7/21.
//

import SwiftUI

///  ** CAVEAT **
/// - `hasNotch` property and the view modifier `AdaptivePaddingOverAllDevices` were
///   introduced to adapt the UI interfaces and elements over various iOS devices.
///   What I found was as the followings:
///     - iOS devices that have a notch have safeAreaInsets.bottom != 0,
///     -  but iOS devices without a notch have safeAreaInsets.bottom == 0,
///     On top of this, `safeAreaInsets.top behavior` or `status bar behavior` is different for iOS devices without a notch from
///     those devices with a notch
///     Therefore, the behavior of each UI element and animation to it will be affected accordingly.


struct AdaptivePaddingOverAllDevices: ViewModifier {
  
  let hasNotch: Bool
  
  let padding_for_notched_device: CGFloat
  
  let padding_for_device_without_notch: CGFloat
  
  func body(content: Content) -> some View {
    
    content.padding(.top, hasNotch ? padding_for_notched_device:padding_for_device_without_notch)
  }
}

extension View {
  
  func adaptivePaddingOverAllDevices(hasNotch: Bool, padding_for_notched_device: CGFloat, padding_for_device_without_notch: CGFloat) -> some View {
    
    modifier(AdaptivePaddingOverAllDevices(hasNotch: hasNotch, padding_for_notched_device: padding_for_notched_device, padding_for_device_without_notch: padding_for_device_without_notch))
  }
}

