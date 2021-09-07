//
//  LowerCellInputView.swift
//  LowerCellInputView
//
//  Created by sungwook on 9/6/21.
//

import SwiftUI
import os.signpost


// TODO: incomplete. not being used yet. it requires performance tuning in the future.

// MARK: Not in use

/// Because I have no time to improve the performane in this challenge.
/// I put it unused for a while.
struct LowerCellInputView: View {
  
  let hasNotch: Bool
  
  let upper_cell_size: CGSize
  
  let lower_cell_size: CGSize
  
  @State var url_string = ""
  @State var inputFieldError = InputFieldError_Enum.noError
  @State var isTextFieldEditing = false
  
  @ObservedObject var dataStore: DataStore
  
  @Binding var is_URLSessionAnimation_Running:Bool
  
  var body: some View {
    
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
          // MARK: UI TESTING "textField url_string"
          .accessibility(identifier: "textField url_string")
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
          // MARK: UI Testing "button url_string"
          .accessibility(identifier: "button url_string")
          .frame(width: lower_cell_size.width * TheGlobalUIParameter.row_width_ratio_of_lower_cell, height: TheGlobalUIParameter.row_height_of_lower_cell, alignment: .center)
          .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue)))
          ///
          /// instead of `.buttonStyle(T##S)`
          .overlay(
            RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(hex_string: ColorEnum.primary_cyan.rawValue)!, lineWidth: TheGlobalUIParameter.overlay_width_for_rounded_border)
                   )
          
          
//          #if XCT_UITEST
//
//          List(uitest__url_string) {
//
//            Text("\($0)")
//          }
//
//          #endif
          
          
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
      }
    }
    
    return inputFieldError == .noError ? true:false
  }
  
  
}



struct LowerCellInputView_Previews: PreviewProvider {
  
    static var previews: some View {
      
      LowerCellInputView(hasNotch: true, upper_cell_size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * TheGlobalUIParameter.the_percenage_of_upper_cell), lower_cell_size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * (1.0-TheGlobalUIParameter.the_percenage_of_upper_cell)), dataStore: sampleDataStore_ForPreviews, is_URLSessionAnimation_Running: Binding(get: { false}, set: {_ in}))
    }
}
