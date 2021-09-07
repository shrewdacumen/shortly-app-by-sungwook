//
//  FasadeView.swift
//  FasadeView
//
//  Created by sungwook on 9/5/21.
//

import SwiftUI

struct FacadeView: View {
  
  let hasNotch: Bool
  
  let the_percenage_of_the_cell: Double
  
  
  var body: some View {
    
    ZStack {
      
      VStack(alignment: .center, spacing: 0) {
        
        Image("logo")
        
        Image("illustration")
          .resizable()
          .aspectRatio(contentMode: .fit)
        
        Spacer()
      }
      /// protect `logo`
      .adaptivePaddingOverAllDevices(hasNotch: hasNotch)
      

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
