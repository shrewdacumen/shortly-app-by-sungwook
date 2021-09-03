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

enum FontSizeEnum: Int {
  
  case bodyCopy = 17
  case mobile = 375
}


// MARK: - ContentView

struct ContentView: View {
  
  // MARK: - sources of truth
  @ObservedObject var dataStore: DataStore
  
  @State var url_string = ""
  @State var isEditing = false
  
  /// This will be the default value 3 sec after tapped the button.
  @State var isButtonTapped = false
  let delay_after_theButtonTapped = 3
  
  // MARK: - properties
  let the_percenage_of_upper_cell = 0.70 /// 70%
  
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
      
      // MARK: - upper cell 2nd
      ScrollView {
        
        Text("Your Link History")
          .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
          .font(Font.custom("Poppins-Regular", size: CGFloat(FontSizeEnum.bodyCopy.rawValue)))
          .padding(.top, 40)
        
        
        ForEach(dataStore.urlPairs) { urlPair in
          
          ZStack(alignment: .center) {
            
            
            /// This view determines the background color of each row.
            RoundedRectangle(cornerRadius: 10)
              .frame(width: upper_cell_size.width*0.85, height: 150, alignment: .topLeading)
              .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
            
            
            // MARK: one row of the source of truth
            VStack {
              
              Text(urlPair.url_string)
                .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
                .font(Font.custom("Poppins-Regular", size: CGFloat(FontSizeEnum.bodyCopy.rawValue)))
                .frame(alignment: .bottom)
              
              Divider()
              
              Text(urlPair.shortened_url)
                .foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue))
                .font(Font.custom("Poppins-Regular", size: CGFloat(FontSizeEnum.bodyCopy.rawValue)))
                .frame(alignment: .top)
              
              
              if isButtonTapped == false {
                
                // TODO: incomplete. make a new SwiftUIView for this.
                ZStack(alignment: .center) {
                  
                  RoundedRectangle(cornerRadius: 5)
                    .frame(width: upper_cell_size.width*0.75, height: 40, alignment: .topLeading)
                    .foregroundColor(Color(hex_string: ColorEnum.primary_cyan.rawValue))
                  
                  Text("COPY")
                    .font(Font.custom("Poppins-Bold", size: CGFloat(FontSizeEnum.bodyCopy.rawValue)))
                    .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
                }
                .frame(alignment: .top)
                
              } else { // The button tapped
                
                ZStack(alignment: .center) {
                  
                  RoundedRectangle(cornerRadius: 5)
                    .frame(width: upper_cell_size.width*0.75, height: 40, alignment: .topLeading)
                    .foregroundColor(Color(hex_string: ColorEnum.neutral_veryDarkViolet.rawValue))
                  
                  Text("COPIED")
                    .font(Font.custom("Poppins-Bold", size: CGFloat(FontSizeEnum.bodyCopy.rawValue)))
                    .foregroundColor(Color(hex_string: ColorEnum.background_white.rawValue))
                }
                .frame(alignment: .top)
                .onAppear {
                  
                  /// this will make isButtonTapped have the default value after delay_after_theButtonTapped sec.
                  DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay_after_theButtonTapped)) {
                    
                    isButtonTapped = false
                  }
                }
                
              }

              
            }
            .padding(.all, 0)
            
          }
          .padding()
          .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
          
        } /// THE END OF ForEach {}
        
        
      }
      .frame(width: upper_cell_size.width, height: upper_cell_size.height, alignment: .top)
      .background(Rectangle().foregroundColor(Color(hex_string: ColorEnum.background_offWhite.rawValue)))
      
      
      // MARK: - Lower Cell
      VStack {
        
        TextField("Shorten a link here", text: $url_string) { isEditing in
          
          self.isEditing = isEditing
          
        } onCommit: {
          
          if url_string.validateUrl() == false {
            
            url_string = ""
          }
          
        }
        .frame(width: lower_cell_size.width * 0.70, height: 40, alignment: .center)
        
        Button {
          
        } label: {
          
          Text("Shorten It")
        }
        
        
      }
      .frame(width: upper_cell_size.width, height: lower_cell_size.height, alignment: .center)
      
      
    } /// THE END OF Top Stack {}
    
  }
  
  //  func validate(url: String) {
  //
  //  }
}


struct ContentView_Previews: PreviewProvider {
  
  static var previews: some View {
    
    ContentView(dataStore: sampleDataStore_ForPreviews)
      
    ContentView(dataStore: sampleDataStore_ForPreviews)
      .preferredColorScheme(.dark)
  }
}
