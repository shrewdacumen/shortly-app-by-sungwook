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
  
  /// `lazy` can NOT be used due to @State
  /// Cannot use mutating getter on immutable value: 'self' is immutable
  var max_screen_size: CGSize {
    
    UIScreen.main.bounds.size
  }
  
  var upper_cell_size: CGSize {
    
    /// 70% of max size
    CGSize(width: max_screen_size.width, height: max_screen_size.height * the_percenage_of_upper_cell)
  }
  
  var lower_cell_size: CGSize {
    
    /// 70% of max size
    CGSize(width: max_screen_size.width, height: max_screen_size.height - upper_cell_size.height)
  }
  
  
  
  var body: some View {
    
    if isTesting_CustomFont {
      
      FontTestView()
        .padding()
    }
    
    
    
    VStack { /// Top Stack
      
      
      if dataStore.urlPairs.isEmpty {
        
        
        // MARK: - Upper cell 1st, FacadeView
        FacadeView(the_percenage_of_the_cell: $the_percenage_of_upper_cell)
        
        
      } else {
        
        
        // MARK: - Upper cell 2nd, ScrollView
        ScrollView {
          
          Text("Your Link History")
            .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
            .font(Font.custom("Poppins-Regular", size: FontSize_Enum.bodyCopy.rawValue))
            .padding(.top, 40)
          
          
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
        
        
        HStack { /// THE BEGINING OF Top Stack {}
          
          /// 1st row
          Spacer()
          
          /// ** CAVEAT **
          /// spacing of the VStack below: the spacing between the input field and the button
          VStack(alignment: .center, spacing: 10) { /// THE BEGINNING OF Lower Celll Stack {}
            
            /// 2nd row
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
            .frame(width: lower_cell_size.width * 0.70, height: 60, alignment: .center)
            .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
            .conditionalOverlay(condition: inputFieldError)
            .onAppear {
              
              /// inputFieldError should be reset after 2_000 milliseconds to make the textField usable.
              if inputFieldError != .noError {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2_000)) {
                  
                  inputFieldError = .noError
                }
              }
            }
            
            
            /// 3rd row
            Button {
              
              //TODO: incomplete. add URL_Session action here!
              
              
              
            } label: {
              
              Text("Shorten It")
                .font(Font.custom("Poppins-Bold", size: FontSize_Enum.bodyCopy.rawValue*TheGlobalUIParameter.shorten_it_ratio))
                .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
              
            }
            .frame(width: lower_cell_size.width * 0.70, height: 60, alignment: .center)
            .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue)))
          }
          
          /// 4th row
          Spacer()
        }
        
        
      } /// THE END OF Lower Celll ZStack {}
      .frame(width: lower_cell_size.width, height: lower_cell_size.height, alignment: .center)
      .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
      )
      
      
      
    } /// THE END OF Top Stack {}
    
  }

  
  
}


struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    
    ContentView(dataStore: sampleDataStore_ForPreviews)
      
    ContentView(dataStore: sampleDataStore_ForPreviews)
      .preferredColorScheme(.dark)
  }
}
