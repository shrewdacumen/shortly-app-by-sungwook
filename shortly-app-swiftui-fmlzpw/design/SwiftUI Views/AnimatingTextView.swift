//
//  AnimatingTextView.swift
//  AnimatingTextView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI

struct AnimatingTextView: View {
  
  @Binding var willAddNewTask_to_create_new_URLSession: Bool
  
  @Binding var is_URLSessionAnimation_Running: Bool
  
  @State var rotationDegree = 0.0

  
  
  /// static func timingCurve(_ c0x: Double, _ c0y: Double, _ c1x: Double, _ c1y: Double, duration: Double = 0.35) -> Animation
  var timeCurveAnimation: Animation {
    
    Animation.timingCurve(0.1, 0.2, 0.6, 0.9, duration: 16).repeatForever()
  }
  
  var body: some View {
    
    
    ZStack {
      
      
      VStack {
        
        if willAddNewTask_to_create_new_URLSession {
          
          Text("Adding a new url")
            .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size_smaller))
            .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
            .onAppear {
              
              DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.adding_a_new_message_duration)) {
                
                withAnimation(.easeIn(duration: 0.5)) {
                  
                  willAddNewTask_to_create_new_URLSession = false
                }
              }
              
            }
            .padding(.top, UIScreen.main.bounds.height*CGFloat(0.15))
          
          
          Spacer()
          
        }
        
      }
      
      
      
      /// URLSession animation
      if is_URLSessionAnimation_Running {
        
        Text("Fetching Data")
          .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size_larger))
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
}

struct AnimatingTextView_Previews: PreviewProvider {
  
    static var previews: some View {
      
      AnimatingTextView(willAddNewTask_to_create_new_URLSession: Binding(get: { true}, set: {_ in }),  is_URLSessionAnimation_Running: Binding(get: { true}, set: {_ in }))
    }
}
