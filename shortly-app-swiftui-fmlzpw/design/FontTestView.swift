//
//  FontTestView.swift
//  FontTestView
//
//  Created by sungwook on 9/2/21.
//

import SwiftUI

struct FontTestView: View {
  var body: some View {
    
    List {
      
      Section(header: Text("1st Test")) {
        
        Text("Popins-Extralight 24")
          .font(Font.custom("Poppins-ExtraLight", size: 24))
        
        
        Text("Popins-Light 24")
          .font(Font.custom("Poppins-Light", size: 24))
        
        HStack {
          
          Text("Popins-Regular 12")
            .font(Font.custom("Poppins-Regular", size: 12))
          
          Text("Popins-Regular 16")
            .font(Font.custom("Poppins-Regular", size: 16))
        }
        
        
        Text("Popins-Regular 20")
          .font(Font.custom("Poppins-Regular", size: 20))
        
        Text("Popins-Regular 24")
          .font(Font.custom("Poppins-Regular", size: 24))
        
      }
      
      
      /// Colors
      Section(header: Text("Colors")) {
        
        ///  Very Dark Violet: #232127
        /// Grayish Violet #35323E -- still too dark
        /// Cyan: #2ACFCF
        /// Red: #F46262
        Text("Popins-Bold 24 Cyan")
        //          .foregroundColor(Color(hex_string: "#35323E"))
          .foregroundColor(Color(hex_string: "#2ACFCF"))
          .font(Font.custom("Poppins-Bold", size: 24))
        
        
        Text("Popins-Bold 24")
        
          .foregroundColor(Color(hex_string: "#F46262"))
          .font(Font.custom("Poppins-Bold", size: 24))
        
        Text("Popins-Black 24")
          .foregroundColor(Color(hex_string: "#35323E"))
          .font(Font.custom("Poppins-Black", size: 24))
        
      }
      
      
      Section(header: Text("3rd Test")) {
        Text("Popins-Thin 24")
          .font(Font.custom("Poppins-Thin", size: 24))
          .frame(alignment: .center)
        
        Text("Popins-Italic 24")
          .font(Font.custom("Poppins-Italic", size: 24))
      }
      
    } /// END OF List
    
  }
}

struct FontTestView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      FontTestView()
      FontTestView()
        .preferredColorScheme(.dark)
      
    }
    
  }
}
