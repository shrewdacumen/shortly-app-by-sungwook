//
//  ContentView.swift
//  shortly-app-swiftui-fmlzpw
//
//  Created by sungwook on 9/2/21.
//

import SwiftUI

// MARK: - from Here, manual parameter to control testings
let isTesting_CustomFont = false

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
}


// MARK: - ContentView

struct ContentView: View {
  
  // MARK: - sources of truth
  @ObservedObject var dataStore: DataStore
  
  @State var url_string = ""
  @State var isTextFieldEditing = false
  
  
  /// in SwiftUI 2.0 way, an old way.
  @State private var isAlertPresented = false
  
  @State private var inputFieldError = InputFieldError_Enum.noError
  
  
  
  // MARK: - properties
  @State var the_percenage_of_upper_cell = TheGlobalUIParameter.the_percenage_of_upper_cell
  
  
  
  
  var body: some View {
    
    if isTesting_CustomFont {
      
      FontTestView()
        .padding()
    }
    
    
    GeometryReader { proxy in
      
      
      let hasNotch = proxy.safeAreaInsets.bottom > 0
      
      let max_displayable_size = hasNotch == false ? CGSize(width: proxy.size.width, height: proxy.size.height - proxy.safeAreaInsets.top) : UIScreen.main.bounds.size
      
      let upper_cell_size =
      CGSize(width: max_displayable_size.width, height: max_displayable_size.height * TheGlobalUIParameter.the_percenage_of_upper_cell)
      
      let lower_cell_size =
      CGSize(width: max_displayable_size.width, height: max_displayable_size.height - upper_cell_size.height)
      
      
      VStack { /// Top Stack
        
        
        if dataStore.urlPairs.isEmpty {
          
          
          // MARK: - Upper cell 1st, FacadeView
          FacadeView(the_percenage_of_the_cell: $the_percenage_of_upper_cell)
            .padding(.top, hasNotch ? 0.0:proxy.safeAreaInsets.top)
          
        } else {
          
          
          // MARK: - Upper cell 2nd, ScrollView
          ScrollView {
            
            Text("Your Link History")
              .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
              .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
              .padding(.top, hasNotch ? 40:10)
            
            
            ForEach(dataStore.urlPairs) { urlPair in
              
              ZStack(alignment: .center) {
                
                
                /// This view determines the background color of each row.
                RoundedRectangle(cornerRadius: 10)
                  .frame(width: upper_cell_size.width*TheGlobalUIParameter.row_width_ratio_of_upper_cell, height: TheGlobalUIParameter.row_height__of_upper_cell, alignment: .topLeading)
                  .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
                
                
                // MARK: one row of the source of truth
                VStack {
                  
                  Text(urlPair.url_string)
                    .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
                    .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
                    .frame(alignment: .bottom)
                  
                  Divider()
                  
                  Text(urlPair.shortened_url)
                    .foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue))
                    .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
                    .frame(alignment: .top)
                  
                  
                  // TODO: incomplete. make a new SwiftUIView for this block.
                  if urlPair.isCopied == false {
                    
                    ZStack(alignment: .center) {
                      
                      RoundedRectangle(cornerRadius: 5)
                        .frame(width: upper_cell_size.width*TheGlobalUIParameter.button_width_ratio_of_upper_cell, height: TheGlobalUIParameter.button_height__of_upper_cell, alignment: .topLeading)
                        .foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue))
                      
                      // TODO: incomplete. add action to Text view to onCopyCommand()
                      Text("COPY")
                        .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue))
                        .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
                    }
                    .frame(alignment: .top)
                    
                  } else { // The button tapped
                    
                    ZStack(alignment: .center) {
                      
                      RoundedRectangle(cornerRadius: 5)
                        .frame(width: upper_cell_size.width*TheGlobalUIParameter.button_width_ratio_of_upper_cell, height: TheGlobalUIParameter.button_height__of_upper_cell, alignment: .topLeading)
                        .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
                      
                      // TODO: incomplete. add action to Text view to onCopyCommand()
                      Text("COPIED")
                        .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue))
                        .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
                    }
                    .frame(alignment: .top)
                    
                  }
                  
                  
                }
                .padding(.all, 0)
                
              }
              .padding()
              .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
              
            } /// THE END OF ForEach {}
            
            
          } /// THE END OF ScrollView {}
          .frame(width: upper_cell_size.width, height: upper_cell_size.height, alignment: .top)
          .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
          
          
        } /// THE END OF if dataStore.urlPairs.isEmpty {}
        
        
        
        // MARK: - Lower Cell, the ZStack
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
                
                /// input string == empty string
                if url_string.isEmpty {
                  
                  inputFieldError = .emptyString
                  
                  isAlertPresented = true
                  
                } else if url_string.validateUrl() == false {
                  
                  inputFieldError = .invalidUrl
                  
                  isAlertPresented = true
                  
                  url_string = ""
                  
                } else {
                  
                  inputFieldError = .noError
                  
                  isAlertPresented = false
                  
                }
                
                
              }
              
              .frame(width: first_row_width_of_lower_cell, height: first_row_height_of_lower_cell, alignment: .center)
              .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
              .conditionalOverlay(condition: inputFieldError)
              .onAppear {
                
                /// inputFieldError should be reset after 2_000 milliseconds to make the textField usable.
                if inputFieldError != .noError {
                  
                  DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1_000)) {
                    
                    inputFieldError = .noError
                  }
                }
              }
              
              
              /// 2nd row
              Button {
                
                //TODO: incomplete. progress bar should appear.
                guard inputFieldError == .noError else {
                  
                  return
                }
       
                
                let queryParams = ["url":url_string]
                var urlComponents = URLComponents()

                var cs = CharacterSet.urlQueryAllowed
                cs.remove("+")

                urlComponents.scheme = "https"
                urlComponents.host = "api.shrtco.de"
                urlComponents.path = "/v2/shorten"
                urlComponents.percentEncodedQuery = queryParams.map {
                  
                    $0.addingPercentEncoding(withAllowedCharacters: cs)!
                    + "=" + $1.addingPercentEncoding(withAllowedCharacters: cs)!
                }.joined(separator: "&")
                
                print("urlString = \(String(describing: urlComponents.string))")
                
                
                
                guard let url = urlComponents.url else {
                  
                  fatalError("wrong url")
                }
                
                // MARK: URLSessionConfiguration.default
                let URLSessionConfig = URLSessionConfiguration.default
                URLSessionConfig.allowsConstrainedNetworkAccess = true
                URLSessionConfig.allowsCellularAccess = true
                URLSessionConfig.waitsForConnectivity = true
                
                
                // MARK: URLSession(configuration: URLSessionConfig).dataTask(with: url) { data, response, error in }
                let urlSessionDataTask = URLSession(configuration: URLSessionConfig).dataTask(with: url) { web_raw_data, response, error in
                  
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
                    return
                    
                  }
                  
                  
                  guard let result = dic["result"] as? [String : String] else {
                    
                    fatalError("result format error")
                  }
                  

                  guard let shortCode = result["full_short_link"] else {
                    
                    fatalError("full_short_link not found")
                  }
                  
                  print("\(shortCode)")
                  
                  dataStore.urlPairs.append(UrlAndShortened_Pair(url_string: url_string, shortened_url: shortCode))
                
                }
                
                
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
            .offset(x: 0, y: hasNotch ? 0:-lower_cell_size.height*0.12)

            
          } /// THE END OF HStack
          .frame(width: lower_cell_size.width, height: lower_cell_size.height, alignment: .center)
          //          .debuggingBorder()
          
          
          
          
        } /// THE END OF Lower Celll ZStack {}
        .frame(width: lower_cell_size.width, height: lower_cell_size.height, alignment: .center)
        .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
        )
        
        
        
      } /// THE END OF Top Stack {}
      .ignoresSafeArea()
      .background(
        
        BackgroundUIView(upper_cell_size: upper_cell_size, lower_cell_size: lower_cell_size)
        
      )
      
    }
    
  }

  
  
}


struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    
    ContentView(dataStore: sampleDataStore_ForPreviews)
      
    ContentView(dataStore: sampleDataStore_ForPreviews)
      .preferredColorScheme(.dark)
  }
}
