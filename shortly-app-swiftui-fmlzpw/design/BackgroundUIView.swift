//
//  BackgroundUIView.swift
//  BackgroundUIView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI

struct BackgroundUIView: View {
  
  let upper_cell_size: CGSize
  let lower_cell_size: CGSize
  
  var body: some View {
    
    ZStack {
      
      VStack {
        
        Rectangle()
          .foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue))
          .frame(width: upper_cell_size.width, height: upper_cell_size.height, alignment: .top)
        
        Spacer()
      }
      
      VStack {
        
        Spacer()
        
        Rectangle()
          .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
          .frame(width: lower_cell_size.width, height: lower_cell_size.height, alignment: .center)
      }
      
    }
    .ignoresSafeArea()
    
    
  }
}

struct BackgroundUIView_Previews: PreviewProvider {
  
    static var previews: some View {
      
      BackgroundUIView(upper_cell_size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * TheGlobalUIParameter.the_percenage_of_upper_cell), lower_cell_size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * (1.0 - TheGlobalUIParameter.the_percenage_of_upper_cell)))
    }
}
