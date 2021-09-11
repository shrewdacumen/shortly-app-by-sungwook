//
//  TextMessageWhileWaitingView.swift
//  TextMessageWhileWaitingView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI


/// The functions that this struct gives:
/// 1. The Transient Error Message from the web endpoint +
/// 2. The Transient Task Message for adding `url_string` +
/// 3. Progress animation
struct TextMessageWhileWaitingView: View {
  
  @Binding var url_string: String

  @Binding var willAddNewTask_to_create_new_URLSession: Bool
  
  /// Transient Error Message from the web endpoint
  @Binding var error_message_from_the_web_endpoint: String?
  
  @Binding var is_URLSessionAnimation_Running: Bool
  
  @State var rotationDegree = 0.0

  
  
  /// static func timingCurve(_ c0x: Double, _ c0y: Double, _ c1x: Double, _ c1y: Double, duration: Double = 0.35) -> Animation
  var timeCurveAnimation: Animation {
    
    Animation.timingCurve(0.1, 0.2, 0.6, 0.9, duration: 16).repeatForever()
  }
  
  var body: some View {
    
    
    ZStack {
      
      ZStack {
        
        //MARK: - The Transient Task Message for adding `url_string`
        VStack {
          
          if willAddNewTask_to_create_new_URLSession {
            
            Text("Adding \(url_string)")
              .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size_smaller))
              .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
              .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.adding_a_new_message_duration)) {
                  
                  withAnimation(.easeIn(duration: 0.5)) {
                    
                    willAddNewTask_to_create_new_URLSession = false
                  }
                }
                
              }
              .padding(.top, UIScreen.main.bounds.height*CGFloat(0.14))
            
            
            Spacer()
            
          }
          
        }
        
        
        //MARK: - The Transient Error Message from the web endpoint
        VStack {
          
          if let error_message_from_the_web_endpoint = error_message_from_the_web_endpoint {
            
            Text("\(error_message_from_the_web_endpoint)")
              .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size_smaller))
              .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
              .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.adding_a_new_message_duration)) {
                  
                  withAnimation(.easeIn(duration: 0.5)) {
                    
                    self.error_message_from_the_web_endpoint = nil
                  }
                }
                
              }
              .padding(.top, UIScreen.main.bounds.height*CGFloat(0.16))
            
            
            Spacer()
            
          }
          
        }
        
      }
      
      
      //MARK: - The animating text that is running until the last URLSession finishes.
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

struct TextMessageWhileWaitingView_Previews: PreviewProvider {
  
    static var previews: some View {
      
      TextMessageWhileWaitingView(url_string: Binding(get: { "sungw.net" }, set: {_ in }),
                                  willAddNewTask_to_create_new_URLSession: Binding(get: { true}, set: {_ in }), 
                                  error_message_from_the_web_endpoint: Binding(get: { nil}, set: {_ in }),
                                   is_URLSessionAnimation_Running: Binding(get: { true}, set: {_ in }))
    }
}
