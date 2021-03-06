//
//  ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView.swift
//  ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI


/// The three child-views that this struct gives:
/// 1. The Transient Task Messages for adding `url_string` +
/// 2. The Transient Error Messages from the web endpoint +
/// 3. Task Progress Information as animating text representation
struct ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView: View {
  
  // MARK: - Inherited the sources of truth.
  @Binding var url_string: String

  @Binding var will_AddNewTaskMessage_for_creating_new_URLSession: Bool
  
  /// Transient Error Message from the web endpoint
  @Binding var error_message_from_the_web_endpoint: String?
  
  @Binding var the_total_number_of_URLSessions: Int
  
  
  
  // MARK: - Native the sources of truth to here!
  @State var rotationDegree = 0.0
  
  @State var hide_addTaskMessage: DispatchWorkItem?

  
  
  /// static func timingCurve(_ c0x: Double, _ c0y: Double, _ c1x: Double, _ c1y: Double, duration: Double = 0.35) -> Animation
  var timeCurveAnimation: Animation {
    
    Animation.timingCurve(0.1, 0.2, 0.6, 0.9, duration: 16).repeatForever()
  }
  
  
  var body: some View {
        
    
    ZStack {
      
      ZStack {
        
        
        // MARK: - 1. The Transient Task Message for adding `url_string`
        VStack {
          
          
          if will_AddNewTaskMessage_for_creating_new_URLSession {
            
            Text("Adding \(url_string)")
              .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size_smaller))
              .foregroundColor(Color(hex_string: ColorEnum.secondary_red.rawValue))
              .animation(.easeIn)
              /// - `onChange(of:)`
              ///   when `the_total_number_of_URLSessions` changes,
              ///   Or when a new `addNewTask` is added again,
              .onChange(of: the_total_number_of_URLSessions) { newValue in
                
                hide_addTaskMessage?.cancel()
                hide_addTaskMessage = nil
                
                hide_AddingTeskMessage_withAnimation()
                

                DEBUG_print("the_total_number_of_URLSessions \(the_total_number_of_URLSessions) \(newValue) cancelled")
              }
              .onAppear {
                
                hide_AddingTeskMessage_withAnimation()
              }
              .padding(.top, UIScreen.main.bounds.height*TheGlobalUIParameter.the_position_of_new_URLSession_message_in_percent)
            
            
            Spacer()
            
          }
          
        }
        
        
        
        // MARK: - 2. The Transient Error Message from the web endpoint
        VStack {
          
          if let error_message_from_the_web_endpoint = error_message_from_the_web_endpoint {
            
            Text("\(error_message_from_the_web_endpoint)")
              .font(Font.custom("Poppins-Bold", size: TheGlobalUIParameter.message_font_size_smallest))
              .lineLimit(nil)
              .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
              .foregroundColor(Color(hex_string: ColorEnum.primary_violet.rawValue))
              .onChange(of: the_total_number_of_URLSessions, perform: { value in
                
                /// This can be a makeshit solution or a safe-guard both.
                ///  so much so that it is uttermost necessary.
                if value == 0 { /// When all pending tasks are done.
                  
                  self.error_message_from_the_web_endpoint = nil
                }
                
              })
              .onAppear {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.the_duration_of_the_Transient_Error_Message_from_the_web_endpoint)) {
                  
                  withAnimation(.easeIn(duration: TheGlobalUIParameter.snappy_animation_duration)) {
                    
                    self.error_message_from_the_web_endpoint = nil
                  }
                }
                
              }
              .padding(.top, UIScreen.main.bounds.height*TheGlobalUIParameter.the_position_of_error_message_from_the_web_endpoint_in_percent)
            
            
            Spacer()
            
          }
          
        }
        
      }
      
      
      
      // MARK: - 3. The Task Progress Information: The animating text that is running until the last URLSession finishes.
      if the_total_number_of_URLSessions > 0 {
        
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
  
  
  /// The animation function, backed by `Dispatch` framework.
  func hide_AddingTeskMessage_withAnimation() {
    
    hide_addTaskMessage = DispatchWorkItem {
      
      withAnimation(.easeIn(duration: TheGlobalUIParameter.snappy_animation_duration)) {
        
        will_AddNewTaskMessage_for_creating_new_URLSession = false
      }
    }
    
    if let hide_addTaskMessage = hide_addTaskMessage {
      
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.the_duration_of_adding_new_task_message), execute: hide_addTaskMessage)
    }
    
  }
  
  
}

struct ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView_Previews: PreviewProvider {
  
    static var previews: some View {
      
      ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView(url_string: Binding(get: { "sungw.net" }, set: {_ in }),
                                  will_AddNewTaskMessage_for_creating_new_URLSession: Binding(get: { true}, set: {_ in }),
                                  error_message_from_the_web_endpoint: Binding(get: { nil}, set: {_ in }),
                                   the_total_number_of_URLSessions: Binding(get: { 1}, set: {_ in }))
    }
}
