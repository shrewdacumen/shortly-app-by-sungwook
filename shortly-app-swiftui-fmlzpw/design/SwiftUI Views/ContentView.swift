//
//  ContentView.swift
//  shortly-app-swiftui-fmlzpw
//
//  Created by sungwook on 9/2/21.
//

import SwiftUI
import os.signpost


/// Because I can NOT use C++ style #define pragma
/// I use the compiler flag in lieu of it.
//#define XCT_UITEST -> compiler flag -D XCT_UITEST


/// According to the following guide line, I created `enum ColorEnum`
///  ### Primary
///
///  - Cyan: #2ACFCF
///  - Dark Violet: #3B3054
///
///  ### Secondary
///
///  - Red: #F46262
///
///  ### Neutral
///
///  - Light Gray: #BFBFBF
///  - Gray: #9E9AA7
///  - Grayish Violet: #35323E
///  - Very Dark Violet: #232127
///
///  ### Background Colors
///
///  - White: #FFFFFF
///  - Off-White: #F0F1F6
///
///  ## Typography
///
///  ### Body Copy
///
///  - Font size: 17px
enum ColorEnum: String {
  
  case black = "#000000"
  case primary_cyan = "#2ACFCF"
  case primary_violet = "#3B3054"
  case secondary_red = "#F46262"
  case neutral_lightGray = "#BFBFBF"
  case neutral_gray = "#9E9AA7"
  case neutral_grayishViolet = "#35323E"
  case neutral_veryDarkViolet = "#232127"
  case background_white = "#FFFFFF"
  case background_offWhite = "#F0F1F6"
}

enum FontSize_Enum: CGFloat {
  
  case bodyCopy = 17.0
  case mobile = 375.0
}

enum InputFieldError_Enum {
  
  case noError
  case emptyString
  case invalidUrl
  case duplicated
}


// MARK: - ContentView

struct ContentView: View {
  
  // MARK: - sources of truth
  @ObservedObject var dataStore: DataStore
  
  
  // MARK: - properties
  let the_percenage_of_upper_cell = TheGlobalUIParameter.the_percenage_of_upper_cell
  
  
  @State var url_string = TheGlobalUIParameter.the_default_string_for_url_string_placeholder
  
  /// URLSession animation is being controlled by `the_total_number_of_URLSessions`
  @State var the_total_number_of_URLSessions = 0
  
  @State var willAddNewTask_to_create_new_URLSession = false
  
  @State var error_message_from_the_web_endpoint: String?

  
  
  // MARK: XCT_UITEST "textField url_string", uncomment the following when UI Testing
  /// Because I use XCT_UITEST symbol in order to save computing loading and memory.
//  #if XCT_UITEST
//
//  @State var uitest__url_string = [String]()
//
//  #endif
  
  
  
  var body: some View {
    
    /// A feature was designed for Testing only.
    ///  To test, set `isTesting_CustomFont` to `true`
    if TheGlobalUIParameter.isTesting_CustomFont {
      
      FontTestView()
        .padding()
    }
    
    
    
    
    GeometryReader { proxy in
      
      /// ** CAVEAT over various iOS devices **
      /// iOS devices that have a notch have safeAreaInsets.top != 0,
      /// but iOS devices that have a notch have safeAreaInsets.top == 0,
      let hasNotch = proxy.safeAreaInsets.bottom > 0
      
      let statusbar_size_foriOSDevicesWithoutANotch = proxy.safeAreaInsets.top
      
      let max_displayable_size = hasNotch == false ? CGSize(width: proxy.size.width, height: proxy.size.height - proxy.safeAreaInsets.top) : UIScreen.main.bounds.size
      
      let upper_cell_size =
        CGSize(width: max_displayable_size.width, height: max_displayable_size.height * TheGlobalUIParameter.the_percenage_of_upper_cell)
      
      let lower_cell_size =
        CGSize(width: max_displayable_size.width, height: max_displayable_size.height - upper_cell_size.height)
      
      
      
      
      /// ZStack for displaying URLSessionAniumation
      ZStack {
        
        /// Because the space btween the_upper_cell and the_lower_cell should be `0`
        VStack(spacing: 0) { /// Top Stack
          
          
          if dataStore.urlPairs.isEmpty {
            
            
            // MARK: - Upper cell 1st, FacadeView
            FacadeView(hasNotch: hasNotch, the_percenage_of_the_cell: the_percenage_of_upper_cell)
              .frame(width: upper_cell_size.width, height: upper_cell_size.height, alignment: .top)
              .padding(.top, hasNotch ? 0.0:proxy.safeAreaInsets.top)
              .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue))
              )
              /// When dataStore.urlPairs.isEmpty, url_string should be as the following.
              .onAppear {
                
                url_string = TheGlobalUIParameter.the_default_string_for_url_string_placeholder
              }
            
          } else {
            
            
            
            // MARK: - Upper cell 2nd, UpperCellDataView
            UpperCellDataView(dataStore: dataStore, hasNotch: hasNotch, upper_cell_size: upper_cell_size, lower_cell_size: lower_cell_size)
            
            
          } /// THE END OF if dataStore.urlPairs.isEmpty {}
          
          
          
          /// This is effective only for iOS devices without a notch.
          SpacerOnlyForOnlyDevicesWithoutANotch(hasNotch: hasNotch, statusbar_size_foriOSDevicesWithoutANotch: statusbar_size_foriOSDevicesWithoutANotch, width_of_the_device: upper_cell_size.width)
          
          
          
          // MARK: - Lower Cell, ZStack
          LowerCellInputView(hasNotch: hasNotch, upper_cell_size: upper_cell_size, lower_cell_size: lower_cell_size,
                             url_string: $url_string,
                             the_total_number_of_URLSessions: $the_total_number_of_URLSessions,
                             willAddNewTask_to_create_new_URLSession: $willAddNewTask_to_create_new_URLSession, error_message_from_the_web_endpoint: $error_message_from_the_web_endpoint,
                             dataStore: dataStore)
            .onAppear {
              
              if the_total_number_of_URLSessions == 0 {
                
                url_string = TheGlobalUIParameter.the_default_string_for_url_string_placeholder
              }
            }
          
          
          
        } /// THE END OF VStack {}
        
        
        if the_total_number_of_URLSessions > 0 || error_message_from_the_web_endpoint != nil {
          
          /// The `url_string` added shall be used immediately that
          ///   It won't block the next message any soon.
          TextMessageWhileWaitingView(url_string: $url_string,
                                      willAddNewTask_to_create_new_URLSession: $willAddNewTask_to_create_new_URLSession,
                                      error_message_from_the_web_endpoint: $error_message_from_the_web_endpoint,
                                      the_total_number_of_URLSessions: $the_total_number_of_URLSessions)
        }
        
        
      } /// THE END OF Top ZStack for displaying URLSessionAniumation
      .ignoresSafeArea()
      .onAppearOrTask {
        
        TheGlobalUIParameter.hasNotch = hasNotch
      }
      
      
    }  /// THE END OF GeometryReader {}
    
  }

  
}


struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    
    ContentView(dataStore: sampleDataStore_ForPreviews)
    
    ContentView(dataStore: sampleDataStore_ForPreviews)
      .preferredColorScheme(.dark)
  }
}
