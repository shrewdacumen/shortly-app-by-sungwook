//
//  String extension.swift
//  String extension
//
//  Created by sungwook on 9/3/21.
//

import Foundation


extension String {
  
  func validateUrl() -> Bool {
    
    /// It turns out that the old version is not user friendly.
    ///let urlRegEx =
    ///"^(http|https|ftp)://([a-zA-Z0-9.-]+(?::[a-zA-Z0-9.&amp;%$-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1][0-9]{2}|[1-9][0-9]|[0-9])|localhost|([a-zA-Z0-9-]+\\.)*[a-zA-Z0-9-]+\\.(com|ru|kz|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(?::[0-9]+)*(/($|[a-zA-Z0-9.,?'\\\\+&amp;%$#=~_-]+))*(?:\\(\\d+\\))?$"
    
    /// The improved regex shall be
    let urlRegEx =
    "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
    
    return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
  }
  
}
