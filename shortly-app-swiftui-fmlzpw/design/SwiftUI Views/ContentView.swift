//
//  ContentView.swift
//  shortly-app-swiftui-fmlzpw
//
//  Created by sungwook on 9/2/21.
//

import SwiftUI
import os.signpost





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
  
  
  
  /// URLSession animation
  @State var  is_URLSessionAnimation_Running = false
  
  /// confined for the lower_cell
  @State var url_string = ""
  @State var inputFieldError = InputFieldError_Enum.noError
  @State var isTextFieldEditing = false
  
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
            
          } else {
            
            
            
            // MARK: - Upper cell 2nd, UpperCellDataView
            UpperCellDataView(dataStore: dataStore, hasNotch: hasNotch, upper_cell_size: upper_cell_size, lower_cell_size: lower_cell_size)
            
            
          } /// THE END OF if dataStore.urlPairs.isEmpty {}
          
          
          
          /// This is effective only for iOS devices without a notch.
          SpacerOnlyForOnlyDevicesWithoutANotch(hasNotch: hasNotch, statusbar_size_foriOSDevicesWithoutANotch: statusbar_size_foriOSDevicesWithoutANotch, width_of_the_device: upper_cell_size.width)
          
          
          
          // MARK: - Lower Cell, ZStack
          
          /// ** NOTE **
          /// Because I have no time to improve the performane in this challenge.
          /// I put it unused for a while.
          //          LowerCellInputView(hasNotch: hasNotch, upper_cell_size: upper_cell_size, lower_cell_size: lower_cell_size, dataStore: dataStore, is_URLSessionAnimation_Running: $is_URLSessionAnimation_Running)
          
          ZStack(alignment: .center) {
            
            
            TheShapeImageView()
            
            let first_row_width_of_lower_cell = lower_cell_size.width * TheGlobalUIParameter.row_width_ratio_of_lower_cell
            let first_row_height_of_lower_cell = TheGlobalUIParameter.row_height_of_lower_cell
            
            HStack { /// THE BEGINING OF Top Stack {}
              
              /// ** CAVEAT **
              /// spacing of the VStack below: the spacing between the input field and the button
              VStack(alignment: .center, spacing: TheGlobalUIParameter.row_spacing_of_lower_cell) { /// THE BEGINNING OF Lower Celll Stack {}
                
                
                /// 1st row
                TextField("Shorten a link here", text: $url_string) { isEditing in
                  
                  self.isTextFieldEditing = isEditing
                  
                } onCommit: {
                  
                  _ = isValidString()
                  
                }
                .font(Font.custom("Poppins-Regular", size: 20))
                .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
                .frame(width: first_row_width_of_lower_cell, height: first_row_height_of_lower_cell, alignment: .center)
                .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
                ///
                /// `conditionalOverlay`
                /// This is designed for displaying the error message over the text field/
                .conditionalOverlay(condition: inputFieldError)
                .onAppear {
                  
                  /// inputFieldError should be reset after 2_000 milliseconds to make the textField usable.
                  if inputFieldError != .noError {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(TheGlobalUIParameter.delay_before_clearing_the_error_message)) {
                      
                      withAnimation(.easeIn(duration: TheGlobalUIParameter.snap_animation_duration)) {
                        
                        inputFieldError = .noError
                      }
                    }
                  }
                }
                
                
                /// 2nd row
                Button {
                  
                  guard isValidString() else {
                    
                    return
                  }
                  
                  
#if DEBUG
                  /// Animation + log started here.
                  print("Just entered URLSession.")
#endif
                  
                  is_URLSessionAnimation_Running = true
                  
                  let osSignpostID = OSSignpostID(log: TheGlobalUIParameter.urlSession_of_Button, object: url_string as AnyObject)
                  
                  /// Testing the performance of the remote web endpoint, SHRTCODE/
                  os_signpost(.event, log: TheGlobalUIParameter.pointsOfInterest, name: "Button URLSession", signpostID: osSignpostID, "Start")
                  
                  
                  let url = urlByURLComponents(from_url_string: url_string)
                  
                  
                  // MARK: URLSessionConfiguration.default
                  let URLSessionConfig = URLSessionConfiguration.default
                  URLSessionConfig.allowsConstrainedNetworkAccess = true
                  URLSessionConfig.allowsCellularAccess = true
                  URLSessionConfig.waitsForConnectivity = true
                  
                  
                  // MARK: URLSession(configuration: URLSessionConfig).dataTask(with: url) { data, response, error in }
                  let urlSessionDataTask = URLSession(configuration: URLSessionConfig).dataTask(with: url) { web_raw_data, response, error in
                    
                    
                    // MARK: - This closure should be a sub-thread.
                    if let response = response {
                      
                      
                      guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                        
                        fatalError()
                      }
                      
                      guard  statusCode == 200 || statusCode == 201 else {
                        
                        print("statusCode = \(statusCode)")
                        print("An unknown error")
                        
                        // TODO: incomplete. returns a message
                        return
                      }
                    }
                    
                    guard let web_raw_data_NonOptional = web_raw_data else {
                      
                      fatalError("no data received")
                    }
                    
                    guard let received_JSONObject = try? JSONSerialization.jsonObject(with: web_raw_data_NonOptional, options: [.mutableContainers]) else {
                      
                      fatalError("the error in jasonObject catch")
                    }
                    
                    
                    if TheGlobalUIParameter.is_debugging_mode {
                      
                      sneakPeak_JSONObject(received_JSONObject)
                    }
                    
                    guard let dic = received_JSONObject as? Dictionary<String, Any> else {
                      
                      fatalError("Dictionary<String, Any>")
                    }
                    
                    
                    if let error_code = dic["error_code"] as? Int {
                      
                      print("error code = \(error_code)")
                      print("\((dic["error"] as? String) ?? "no error message")")
                      
                      // TODO: incomplete. returns a message
                      // TODO: where should I display this??? which is not specified in the code challenge!!!
                      return
                      
                    }
                    
#if DEBUG
                    /// If this happens, it is caused by the programming logic.
                    /// Therefore, it is safe to fatalError()
                    guard let result = dic["result"] as? [String : String] else {
                      
                      fatalError("result format error")
                    }
                    
                    /// If this happens, it is caused by the programming logic.
                    /// Therefore, it is safe to fatalError()
                    guard let shortCode = result["full_short_link"] else {
                      
                      fatalError("full_short_link not found")
                    }
                    
                    
                    print("\(shortCode)")
#endif
                    
                    ///  this should be on main thread, for updating the source of truth.
                    DispatchQueue.main.async {
                      
                      /// stop the animation
                      is_URLSessionAnimation_Running = false
                      
                      /// Testing the performance of the remote web endpoint, SHRTCODE/
                      os_signpost(.event, log: TheGlobalUIParameter.pointsOfInterest, name: "Button URLSession", signpostID: osSignpostID, "End")
                      
                      withAnimation(.easeIn(duration: TheGlobalUIParameter.animation_duration)) {
                        
                        dataStore.urlPairs.append(UrlAndShortened_Pair(url_string: url_string, shortened_url: shortCode))
                        
                        /// reset the url_string after the use.
                        url_string = ""
                      }
                    }
                    
                    
                  } /// THE END OF URLSessionConfig).dataTask(with: url)  {}
                  
                  
                  urlSessionDataTask.resume()
                  
                  
                } label: {
                  
                  Text("Shorten It")
                    .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue*TheGlobalUIParameter.shorten_it_ratio))
                    .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
                  
                }
                .frame(width: lower_cell_size.width * TheGlobalUIParameter.row_width_ratio_of_lower_cell, height: TheGlobalUIParameter.row_height_of_lower_cell, alignment: .center)
                .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue)))
                
                
              }  /// THE END OF VStack {}
              //            .debuggingBorder()
              
              
            } /// THE END OF HStack
            .frame(width: lower_cell_size.width, height: lower_cell_size.height, alignment: .center)
            //          .debuggingBorder()
            
            
            
            
          } /// THE END OF Lower Celll ZStack {}
          .frame(width: lower_cell_size.width, height: lower_cell_size.height, alignment: .bottom)
          .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
          )
          
          
        } /// THE END OF VStack {}
        
        
        if is_URLSessionAnimation_Running {
          
          
          AnimatingTextView(is_URLSessionAnimation_Running: $is_URLSessionAnimation_Running)
        }
        
        
      } /// THE END OF Top ZStack for displaying URLSessionAniumation
      .ignoresSafeArea()
      
    }
    
  }
  
  
  
  func isValidString() -> Bool {
    
    withAnimation(.easeIn(duration: TheGlobalUIParameter.snap_animation_duration)) {
      
      /// input string == empty string
      if url_string.isEmpty {
        
        inputFieldError = .emptyString
        
      } else if url_string.validateUrl() == false {
        
        inputFieldError = .invalidUrl
        
        url_string = ""
        
      } else if dataStore.doesContain(url_string: url_string) {
        
        inputFieldError = .duplicated
        
        url_string = ""
        
      } else {
        
        inputFieldError = .noError
      }
    }
    
    return inputFieldError == .noError ? true:false
  }
  
  
}


struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    
    ContentView(dataStore: sampleDataStore_ForPreviews)
    
    ContentView(dataStore: sampleDataStore_ForPreviews)
      .preferredColorScheme(.dark)
  }
}
