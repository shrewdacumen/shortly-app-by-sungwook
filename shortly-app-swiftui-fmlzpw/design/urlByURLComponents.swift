//
//  urlByURLComponents.swift
//  urlByURLComponents
//
//  Created by sungwook on 9/7/21.
//

import Foundation


func urlByURLComponents(from_url_string url_string:String ) -> URL {
  
  
  let queryParams = ["url" : url_string]
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
    
    /// This will only happen when it is under development.
    fatalError("wrong url")
  }
  
  return url
  
}
