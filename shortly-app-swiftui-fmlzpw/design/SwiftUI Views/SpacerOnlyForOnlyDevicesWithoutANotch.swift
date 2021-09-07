//
//  SpacerOnlyForOnlyDevicesWithoutANotch.swift
//  SpacerOnlyForOnlyDevicesWithoutANotch
//
//  Created by sungwook on 9/7/21.
//

import SwiftUI


/// This is effective only for iOS devices without a notch.
struct SpacerOnlyForOnlyDevicesWithoutANotch: View {
  
  let hasNotch: Bool
  
  let statusbar_size_foriOSDevicesWithoutANotch: CGFloat
  
  let width_of_the_device: CGFloat
  
  var body: some View {
    
    /// This is effective only for iOS devices without a notch.
    if hasNotch == false {
      
      Spacer()
        .frame(width: width_of_the_device, height: statusbar_size_foriOSDevicesWithoutANotch*2.0, alignment: .center)
        .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
    }
  }
}

struct SpacerOnlyForOnlyDevicesWithoutANotch_Previews: PreviewProvider {
    static var previews: some View {
      SpacerOnlyForOnlyDevicesWithoutANotch(hasNotch: false, statusbar_size_foriOSDevicesWithoutANotch: 20, width_of_the_device: UIScreen.main.bounds.width)
    }
}
