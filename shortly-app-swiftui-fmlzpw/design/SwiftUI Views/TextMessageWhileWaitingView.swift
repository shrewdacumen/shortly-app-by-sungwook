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
  
  @Binding var the_total_number_of_URLSessions: Int
  
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.the_duration_of_adding_new_task_message)) {
                  
                  withAnimation(.easeIn(duration: 0.5)) {
                    
                    willAddNewTask_to_create_new_URLSession = false
                  }
                }
                
              }
              .padding(.top, UIScreen.main.bounds.height*TheGlobalUIParameter.the_position_of_new_URLSession_message_in_percent)
            
            
            Spacer()
            
          }
          
        }
        
        
        //MARK: - The Transient Error Message from the web endpoint
        VStack {
          
          if let error_message_from_the_web_endpoint = error_message_from_the_web_endpoint {
            
            Text("\(error_message_from_the_web_endpoint)")
              .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size_smallest))
              .lineLimit(nil)
              .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color(hex_string: ColorEnum.primary_violet.rawValue))
              .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.the_duration_of_the_Transient_Error_Message_from_the_web_endpoint)) {
                  
                  withAnimation(.easeIn(duration: 0.5)) {
                    
                    self.error_message_from_the_web_endpoint = nil
                  }
                }
                
              }
              .padding(.top, UIScreen.main.bounds.height*TheGlobalUIParameter.the_position_of_error_message_from_the_web_endpoint_in_percent)
            
            
            Spacer()
            
          }
          
        }
        
      }
      
      
      //MARK: - The animating text that is running until the last URLSession finishes.
      if is_URLSessionAnimation_Running {
        
        Text("Fetching Data\n(\(the_total_number_of_URLSessions) tasks)")
          .lineLimit(nil)
          .multilineTextAlignment(.center)
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
                                   is_URLSessionAnimation_Running: Binding(get: { true}, set: {_ in }),
                                   the_total_number_of_URLSessions: Binding(get: { 1}, set: {_ in }))
    }
}
