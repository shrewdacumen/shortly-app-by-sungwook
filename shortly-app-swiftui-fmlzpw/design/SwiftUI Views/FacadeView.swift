//
//  FasadeView.swift
//  FasadeView
//
//  Created by sungwook on 9/5/21.
//

import SwiftUI

struct FacadeView: View {
  
  let hasNotch: Bool
  
  let the_percenage_of_the_cell: CGFloat
  
  
  var body: some View {
    
    let illustration_padding_to_eclipse_logo = CGFloat(20)
    
    ZStack {
      
      VStack(alignment: .center, spacing: 0) {
        
        Image("logo")
        
        Spacer()
      }
      /// protect `logo`
      .adaptivePaddingOverAllDevices(hasNotch: hasNotch, padding_for_notched_device: TheGlobalUIParameter.padding_to_avoid_notch, padding_for_device_without_notch: TheGlobalUIParameter.padding_to_avoid_statusBar)
      
      
      VStack(alignment: .center, spacing: 0) {
        
        Image("illustration")
          .resizable()
          .aspectRatio(contentMode: .fit)
        
        Spacer()
      }
      .adaptivePaddingOverAllDevices(hasNotch: hasNotch, padding_for_notched_device: TheGlobalUIParameter.padding_to_avoid_notch + illustration_padding_to_eclipse_logo, padding_for_device_without_notch: TheGlobalUIParameter.padding_to_avoid_statusBar + illustration_padding_to_eclipse_logo)
      

      VStack(alignment: .center, spacing: 0) {
        
        Spacer()
        
        Text("Let's get started!")
          .foregroundColor(Color(hex_string: ColorEnum.neutral_grayishViolet.rawValue))
          .font(Font.custom("Poppins-Black", size: 20))
        
        Text("Paste your first link into")
          .foregroundColor(Color(hex_string: ColorEnum.neutral_grayishViolet.rawValue))
          .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
        
        Text("the field to shorten it")
          .foregroundColor(Color(hex_string: ColorEnum.neutral_grayishViolet.rawValue))
          .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
      }
      .padding(.bottom, 40)

      
    }  /// THE END OF ZStack {}
    
  } /// THE END OF body {}
  
}


struct FasadeView_Previews: PreviewProvider {
    static var previews: some View {
      
      FacadeView(hasNotch: true, the_percenage_of_the_cell: TheGlobalUIParameter.the_percenage_of_upper_cell)
      
      FacadeView(hasNotch: true, the_percenage_of_the_cell: TheGlobalUIParameter.the_percenage_of_upper_cell)
        .preferredColorScheme(.dark)
    }
}
