//
//  LowerCellInputView.swift
//  LowerCellInputView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI
import os.signpost


/// Because I can NOT use C++ style #define pragma
/// I use the compiler flag in lieu of it.
//#define XCT_UITEST -> compiler flag -D XCT_UITEST




struct LowerCellInputView: View {
  
  let hasNotch: Bool
  
  let upper_cell_size: CGSize
  
  let lower_cell_size: CGSize
  
  
  // MARK: - Binding properties
  @Binding var url_string: String
  
  /// URLSession animation is being controlled by `the_total_number_of_URLSessions`
  @Binding var the_total_number_of_URLSessions: Int
  
  @Binding var will_AddNewTaskMessage_for_creating_new_URLSession: Bool
  
  @Binding var error_message_from_the_web_endpoint: String?
  
  
  // MARK: - confined for the lower_cell
  @State var inputFieldError = InputFieldError_Enum.noError
  
  @State var isTextFieldEditing = false
  
  
  // MARK: - ObservedObject
  @ObservedObject var dataStore: DataStore
  
  
  
  var body: some View {
    
    
    ZStack(alignment: .center) {
      
      // MARK: XCT_UITEST "textField url_string", uncomment the following when UI Testing
//      #if XCT_UITEST
//
//      List(uitest__url_string, id: \.self) {
//
//        Text("\($0)")
//          .foregroundColor(Color.yellow)
//      }
//
//      #endif
      
      
      TheShapeImageView()
      
      let first_row_width_of_lower_cell = lower_cell_size.width * TheGlobalUIParameter.row_width_ratio_of_lower_cell
      let first_row_height_of_lower_cell = TheGlobalUIParameter.row_height_of_lower_cell
      
      HStack { /// THE BEGINING OF Top Stack {}
        
        /// ** CAVEAT **
        /// spacing of the VStack below: the spacing between the input field and the button
        VStack(alignment: .center, spacing: TheGlobalUIParameter.row_spacing_of_lower_cell) { /// THE BEGINNING OF Lower Celll Stack {}
          
          
          /// 1st row
          TextField(TheGlobalUIParameter.the_default_string_for_url_string_placeholder, text: $url_string) { isEditing in
            
            self.isTextFieldEditing = isEditing
            
          } onCommit: {
            
            _ = isValidString()
            
          }
          .onTapGesture {  /// Upon tap, url_string should be "" for the convenience of the user.
            
            url_string = ""
          }
          // MARK: XCT_UITEST "textField url_string", uncomment the following when UI Testing
//          .accessibility(identifier: "textField url_string")
          /// center the placeholder text.
          .multilineTextAlignment(TextAlignment.center)
          .font(Font.custom("Poppins-Regular", size: 20))
          .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
          .frame(width: first_row_width_of_lower_cell, height: first_row_height_of_lower_cell, alignment: .center)
          .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
          ///
          /// instead of `.textFieldStyle(RoundedBorderTextFieldStyle())`
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(Color(hex_string: ColorEnum.background_offWhite.rawValue)!, lineWidth: TheGlobalUIParameter.overlay_width_for_rounded_border)
          )
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
            
            self.initialization_of_this_URLSession()
            
            
            let osSignpostID = OSSignpostID(log: TheGlobalUIParameter.urlSession_of_Button, object: url_string as AnyObject)
            
            /// Testing the performance of the remote web endpoint, SHRTCODE/
            os_signpost(.event, log: TheGlobalUIParameter.pointsOfInterest, name: "Button URLSession", signpostID: osSignpostID, "Start")
            
            
            /// `url_string_private_for_this_URLSession` is introduced due to the following reasion.
            /// The feature of multiple input field attempts while waiting for getting previous short-code from the remote endpoint.
            ///
            /// url_string shall be "" just before typeing any url by onTapGesture()
            /// And then be validated again by `func isValidString()`.
            /// Therefore, do NOT worry about invalid url string
            let url_string_private_for_this_URLSession = url_string
            
            
            let url = urlByURLComponents(from_url_string: url_string_private_for_this_URLSession)
            
            
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
                  
                  //MARK: The Transient Error Message from the web endpoint
                  set_error_message_from_the_web_endpoint(with_url_string: url_string_private_for_this_URLSession)
                  
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
                
                fatalError("Wrong JSon Format! (should be Dictionary<String, Any>)")
              }
              
              
              if let error_code = dic["error_code"] as? Int {
                
                print("error code = \(error_code)")
                print("\((dic["error"] as? String) ?? "no error message")")
                
                //MARK: The Transient Error Message from the web endpoint
                set_error_message_from_the_web_endpoint(with_url_string: url_string_private_for_this_URLSession)
                
                return
              }
              
              
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
              
              
              #if DEBUG
              print("\(shortCode)")
              #endif
              
              
              ///  this should be on main thread, for updating the source of truth.
              DispatchQueue.main.async {
                
                /// Testing the performance of the remote web endpoint, SHRTCODE/
                os_signpost(.event, log: TheGlobalUIParameter.pointsOfInterest, name: "Button URLSession", signpostID: osSignpostID, "End")
                
                withAnimation(.easeIn(duration: TheGlobalUIParameter.animation_duration)) {
                  
                  /// This is necessary until this URLSession gets from the remote endpoint,
                  ///  by the logic it is impossible to determine whether it is a duplicate or not.
                  ///  Partly because there can be an error from the endpoint as well.
                  ///
                  /// And this can **NOT** be the state `.duplicated` of `InputFieldError_Enum`
                  /// Because it is **NEITHER** a part of `InputFieldError_Enum`.
                  if dataStore.doesContain(url_string: url_string_private_for_this_URLSession) {
                    
                    error_message_from_the_web_endpoint = "Task \(url_string_private_for_this_URLSession):\n It is a duplicate!"
                    
                  } else {
                    
                    dataStore.urlPairs.append(UrlAndShortened_Pair(url_string: url_string_private_for_this_URLSession, shortened_url: shortCode))
                  }
                  
                  
                  /// if there aren't another URLSession is running,
                  /// Or, to paraphrase this, if this is the last URLSession that the user asked for,
                  if self.the_total_number_of_URLSessions == 1 {
                    
                    /// reset the url_string after the use.
                    url_string = TheGlobalUIParameter.the_default_string_for_url_string_placeholder
                  }
                  
                  /// this URLSession is done
                  self.the_total_number_of_URLSessions -= 1
                }
                
              }
              
              
            } /// THE END OF URLSessionConfig).dataTask(with: url)  {}
            
            
            urlSessionDataTask.resume()
            
            
          } label: {
            
            Text("Shorten It")
              .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue*TheGlobalUIParameter.shorten_it_ratio))
              .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
            
          }
          // MARK: XCT_UITEST "textField url_string", uncomment the following when UI Testing
//          .accessibility(identifier: "button url_string")
          .frame(width: lower_cell_size.width * TheGlobalUIParameter.row_width_ratio_of_lower_cell, height: TheGlobalUIParameter.row_height_of_lower_cell, alignment: .center)
          .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue)))
          ///
          /// instead of `.buttonStyle(<#T##S#>)`
          .overlay(
            RoundedRectangle(cornerRadius: 5)
              .stroke(Color(hex_string: ColorEnum.primary_cyan.rawValue)!, lineWidth: TheGlobalUIParameter.overlay_width_for_rounded_border)
          )
          
          
        }  /// THE END OF VStack {}
        //            .debuggingBorder()
        
        
      } /// THE END OF HStack
      .frame(width: lower_cell_size.width, height: lower_cell_size.height, alignment: .center)
      //          .debuggingBorder()
      
      
      
      
    } /// THE END OF Lower Celll ZStack {}
    .frame(width: lower_cell_size.width, height: lower_cell_size.height, alignment: .bottom)
    .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
    )
    
    
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
        
        // MARK: XCT_UITEST "textField url_string", uncomment the following when UI Testing
//        #if XCT_UITEST
//        uitest__url_string.append(url_string)
//        #endif
        
      }
    }
    
    return inputFieldError == .noError ? true:false
  }
  
  
  
  func initialization_of_this_URLSession() {
    
    /// initialization of this URLSession
    self.will_AddNewTaskMessage_for_creating_new_URLSession = true
    
    self.the_total_number_of_URLSessions += 1
    
    
    /// This will be set by the `ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView`.
    //    self.error_message_from_the_web_endpoint = nil
  }
  
  
  func set_error_message_from_the_web_endpoint(with_url_string url_string: String) {
    
    self.error_message_from_the_web_endpoint = "Task \(url_string):\n An Error from the SHRTCODE endpoint"
    
    self.the_total_number_of_URLSessions -= 1
  }
  
  
}



struct LowerCellInputView_Previews: PreviewProvider {
  
  static var previews: some View {
    
    LowerCellInputView(hasNotch: true, upper_cell_size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * TheGlobalUIParameter.the_percenage_of_upper_cell), lower_cell_size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * (1.0-TheGlobalUIParameter.the_percenage_of_upper_cell)),
                       url_string: Binding(get: { "SungW.net" }, set: {_ in }),
                       the_total_number_of_URLSessions: Binding(get: { 0 }, set: {_ in }),
                       will_AddNewTaskMessage_for_creating_new_URLSession: Binding(get: { true }, set: {_ in }),
                       error_message_from_the_web_endpoint: Binding(get: {nil}, set: {_ in}),
                       dataStore: sampleDataStore_ForPreviews
    )
  }
}
