//
//  UpperCellDataView.swift
//  UpperCellDataView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI

struct UpperCellDataView: View {
  
  @ObservedObject var dataStore: DataStore
  
  let hasNotch: Bool
  
  let upper_cell_size: CGSize
  
  let lower_cell_size: CGSize
  
  
  var body: some View {
    
    ScrollView {
      
      Text("Your Link History")
        .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
        .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
        .padding(.top, hasNotch ? 40:10)
      
      
      ForEach(dataStore.urlPairs) { urlPair in
        
        ZStack(alignment: .center) {
          
          
          /// This view determines the background color of each row.
          RoundedRectangle(cornerRadius: 10)
            .frame(width: upper_cell_size.width*TheGlobalUIParameter.row_width_ratio_of_upper_cell, height: TheGlobalUIParameter.row_height__of_upper_cell, alignment: .topLeading)
            .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
          
          
          // MARK: one row of the source of truth
          VStack {
            
            
            HStack {
              
              Text(urlPair.url_string)
                .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
                .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
                .frame(alignment: .bottom)
              
              Image("del")
                .onTapGesture {
                  
                  withAnimation(.easeIn(duration: TheGlobalUIParameter.animation_duration)) {
                    
                    dataStore.remove(urlPair: urlPair)
                  }
                }
            }
            
            
            Divider()
            
            Text(urlPair.shortened_url)
              .foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue))
              .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
              .frame(alignment: .top)
            
            
            CopyButtonView(upper_cell_size: upper_cell_size, urlPair: urlPair)
            
            
          }
          .padding(.all, 0)
          
        }
        .padding(.bottom, 5)
        .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
        
      } /// THE END OF ForEach {}
      
      
    } /// THE END OF ScrollView {}
    .frame(width: upper_cell_size.width, height: upper_cell_size.height, alignment: .top)
    .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
    
  }
  
}



struct UpperCellDataView_Previews: PreviewProvider {
    static var previews: some View {
        UpperCellDataView(dataStore: sampleDataStore_ForPreviews, hasNotch: true, upper_cell_size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * TheGlobalUIParameter.the_percenage_of_upper_cell), lower_cell_size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * (1.0-TheGlobalUIParameter.the_percenage_of_upper_cell)))
    }
}
