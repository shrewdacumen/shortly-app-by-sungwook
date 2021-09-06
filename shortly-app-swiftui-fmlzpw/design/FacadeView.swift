//
//  FasadeView.swift
//  FasadeView
//
//  Created by sungwook on 9/5/21.
//

import SwiftUI

struct FacadeView: View {
  
  @Binding var the_percenage_of_the_cell: Double
  
  
  var body: some View {
    
    VStack(alignment: .center, spacing: 10) {
      
      Image("logo")
        .padding(.top, 100)
      
      
      
      Image("illustration")
      
      
      
      VStack(alignment: .center, spacing: 10) {
        
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
      
      //      Spacer()
      
    }
    //    .frame(width: the_percenage_of_the_cell*UIScreen.main.bounds.width, height: the_percenage_of_the_cell*UIScreen.main.bounds.height, alignment: .top)
    
  }
}

struct FasadeView_Previews: PreviewProvider {
    static var previews: some View {
      
      FacadeView(the_percenage_of_the_cell: Binding(get: {return TheGlobalUIParameter.the_percenage_of_upper_cell}, set: {_ in }))
      
      FacadeView(the_percenage_of_the_cell: Binding(get: {return TheGlobalUIParameter.the_percenage_of_upper_cell}, set: {_ in }))
        .preferredColorScheme(.dark)
    }
}
