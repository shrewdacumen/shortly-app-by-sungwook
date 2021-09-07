//
//  AnimatingTextView.swift
//  AnimatingTextView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI

struct AnimatingTextView: View {
  
  @Binding var is_URLSessionAnimation_Running: Bool
  
  @State var rotationDegree = 0.0
  
  
  /// static func timingCurve(_ c0x: Double, _ c0y: Double, _ c1x: Double, _ c1y: Double, duration: Double = 0.35) -> Animation
  var timeCurveAnimation: Animation {
    
    Animation.timingCurve(0.1, 0.2, 0.6, 0.9, duration: 16).repeatForever()
  }
  
  var body: some View {
    
    /// URLSession animation
    if is_URLSessionAnimation_Running {
      
      Text("Fetching Data")
        .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size))
        .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
        .rotationEffect(.degrees(rotationDegree))
        .onAppear {
          
          withAnimation(self.timeCurveAnimation) {
            
            self.rotationDegree = 1_440.0
          }
        }
      
    } else {
      
      EmptyView()
    }
    
  }
}

struct AnimatingTextView_Previews: PreviewProvider {
  
    static var previews: some View {
      
        AnimatingTextView(is_URLSessionAnimation_Running: Binding(get: { true}, set: {_ in }))
    }
}
