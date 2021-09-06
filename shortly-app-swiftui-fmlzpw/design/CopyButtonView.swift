//
//  CopyButtonView.swift
//  CopyButtonView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI

struct CopyButtonView: View {
  
  let upper_cell_size: CGSize
  
  @ObservedObject var urlPair: UrlAndShortened_Pair
  
  
  
  @State var is_Copied_Alive = false
  
  
  var body: some View {
    
    // TODO: incomplete. make a new SwiftUIView for this block.
    if urlPair.isCopied == false {
      
      ZStack(alignment: .center) {
        
        RoundedRectangle(cornerRadius: 5)
          .frame(width: upper_cell_size.width*TheGlobalUIParameter.button_width_ratio_of_upper_cell, height: TheGlobalUIParameter.button_height__of_upper_cell, alignment: .topLeading)
          .foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue))
        
        // TODO: incomplete. add action to Text view to onCopyCommand()
        Text("COPY")
          .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue))
          .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
          .onTapGesture {
            
            UIPasteboard.general.string = urlPair.shortened_url
            
            urlPair.isCopied = true
            
            withAnimation(.easeIn(duration: 1.0)) {
              
              is_Copied_Alive = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.message_animation_duration)) {
             
              withAnimation(.easeIn(duration: 1.0)) {
                
              is_Copied_Alive = false
              }
              
            }
          }
        
        if is_Copied_Alive {
          
          Text("COPIED")
            .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size))
            .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
        }
        
      }
      .frame(alignment: .top)
      
    } else { // The button tapped
      
      ZStack(alignment: .center) {
        
        RoundedRectangle(cornerRadius: 5)
          .frame(width: upper_cell_size.width*TheGlobalUIParameter.button_width_ratio_of_upper_cell, height: TheGlobalUIParameter.button_height__of_upper_cell, alignment: .topLeading)
          .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
        
        // TODO: incomplete. add action to Text view to onCopyCommand()
        Text("COPIED")
          .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue))
          .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
          .onTapGesture {
            
            UIPasteboard.general.string = urlPair.shortened_url
            
            withAnimation(.easeIn(duration: 1.0)) {
              
            is_Copied_Alive = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.message_animation_duration)) {
              
              withAnimation(.easeIn(duration: 1.0)) {
                
              is_Copied_Alive = false
              }
            }
          }
        
        if is_Copied_Alive {
          
          Text("COPIED")
            .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size))
            .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
        }
        
      }
      .frame(alignment: .top)
      
    }
    
  }
 
}



//struct CopyButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        CopyButtonView()
//    }
//}
