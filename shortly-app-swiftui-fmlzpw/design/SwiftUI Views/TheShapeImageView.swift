//
//  TheShapeImageView.swift
//  TheShapeImageView
//
//  Created by sungwook on 9/5/21.
//

import SwiftUI

struct TheShapeImageView: View {
  
    var body: some View {
      
      VStack {
        
        HStack {
          
          Spacer()
          
          Image("shape")
        }
        
        Spacer()
      }
      
    }
}

struct TheShapeImageView_Previews: PreviewProvider {
    static var previews: some View {
        TheShapeImageView()
    }
}
