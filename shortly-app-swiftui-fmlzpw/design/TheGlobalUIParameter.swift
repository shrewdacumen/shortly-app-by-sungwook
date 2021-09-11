//
//  TheGlobalUIParameter.swift
//  TheGlobalUIParameter
//
//  Created by sungwook on 9/5/21.
//

import SwiftUI
import os.signpost


struct TheGlobalUIParameter {
  
  static var hasNotch = true  /// iPhone12 is the default device.
  
  
  static let pointsOfInterest = OSLog(subsystem: "net.sungw.utility.experimental.shortly-app-swiftui-fmlzpw", category: .pointsOfInterest)
  static let urlSession_of_Button = OSLog(subsystem: "net.sungw.utility.experimental.shortly-app-swiftui-fmlzpw", category: "urlSession_of_Button")
  
  // MARK: - from Here, manually valued parameter to control testings only
  /// A feature was designed for Testing only.
  ///  To test, set `isTesting_CustomFont` to `true`
  static let isTesting_CustomFont = false
  
  static let overlay_width_for_rounded_border = CGFloat(3)
  
  static let padding_to_avoid_notch = CGFloat(40)
  
  static let padding_to_avoid_statusBar = CGFloat(20)
  
  /// This controls if it is in debugging mode or not.
  /// I can use the compiler's DEBUG label intead of this
  /// Or I can consolidate both ways to a single way.
  ///
  /// However, this is made as a demonstration to make it easier/clearer for the recruiter to uncderstand.
  static let is_debugging_mode = true
  
  static let animation_duration = TimeInterval(1.3)
  
  /// The Transient Task Message for adding `url_string`
  static let the_duration_of_adding_new_task_message = 700 /// in milliseconds.
  static let the_position_of_new_URLSession_message_in_percent = CGFloat(0.11) /// The below can NOT be the same.
  
  /// The Transient Error Message from the web endpoint
  static let the_duration_of_the_Transient_Error_Message_from_the_web_endpoint = 2_500 /// in milliseconds.
  static let the_position_of_error_message_from_the_web_endpoint_in_percent = CGFloat(0.15)
  
  static let message_font_size_smallest = CGFloat(20)
  static let message_font_size_smaller = CGFloat(30)
  static let message_font_size_larger = CGFloat(40)
  
  static let message_animation_duration = 1_000
  
  /// This is related to the animation as well.
  ///  If this value (in milliseconds) is too high, the user may hate it.
  static let delay_before_clearing_the_error_message = 850
  
  static let snap_animation_duration = TimeInterval(0.2)
  
  static let the_percenage_of_upper_cell = CGFloat(0.70) /// 70%
  
  /// rows of upper cell
  static let row_width_ratio_of_upper_cell = CGFloat(0.85)
  static let row_height__of_upper_cell = CGFloat(150)
  
  /// buttons of rows of upper cell
  static let button_width_ratio_of_upper_cell = CGFloat(0.75)
  static let button_height__of_upper_cell = CGFloat(40)
  
  static let row_width_ratio_of_lower_cell = CGFloat(0.70)
  static let row_height_of_lower_cell = CGFloat(40)
  static let row_spacing_of_lower_cell = CGFloat(8)
  
  
  static let shorten_it_ratio = CGFloat(1.5)
}
