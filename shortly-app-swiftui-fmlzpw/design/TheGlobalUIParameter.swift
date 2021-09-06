//
//  TheGlobalUIParameter.swift
//  TheGlobalUIParameter
//
//  Created by sungwook on 9/5/21.
//

import SwiftUI



struct TheGlobalUIParameter {
  
  /// This controls if it is in debugging mode or not.
  /// I can use the compiler's DEBUG label intead of this
  /// Or I can consolidate both ways to a single way.
  ///
  /// However, this is made as a demonstration to make it easier/clearer for the recruiter to uncderstand.
  static let is_debugging_mode = true
  
  
  
  static let the_percenage_of_upper_cell = 0.65 /// 65%
  
  /// rows of upper cell
  static let row_width_ratio_of_upper_cell = CGFloat(0.85)
  static let row_height__of_upper_cell = CGFloat(150)
  
  /// buttons of rows of upper cell
  static let button_width_ratio_of_upper_cell = CGFloat(0.75)
  static let button_height__of_upper_cell = CGFloat(40)
  
  static let row_width_ratio_of_lower_cell = CGFloat(0.70)
  static let row_height_of_lower_cell = CGFloat(40)
  static let row_spacing_of_lower_cell = CGFloat(5)
  
  
  static let shorten_it_ratio = CGFloat(1.5)
}