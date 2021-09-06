//
//  UrlAndShortened_Pair.swift
//  UrlAndShortened_Pair
//
//  Created by sungwook on 9/2/21.
//

import Foundation


class UrlAndShortened_Pair: Identifiable, Equatable, ObservableObject {
  
  let id = UUID()
  let url_string: String /// use this as key value
  let shortened_url: String
  
  /// I make isCopied chagible and persistent.
  /// it is pertain to onCopyCommand(perform:)
  @Published var isCopied = false
  
  init(url_string: String, shortened_url: String) {
    
    self.url_string = url_string
    self.shortened_url = shortened_url
  }
  
  /// I use `url_string` as the key so that all equality should conform the same way.
  static func ==(left: UrlAndShortened_Pair, right: UrlAndShortened_Pair) -> Bool {
    
    left.url_string == right.url_string
  }
  
}



class DataStore: ObservableObject {
  
  @Published var urlPairs: [UrlAndShortened_Pair]
  
  func doesContain(url_string: String) -> Bool {
    
    let found = urlPairs.first {
      
      $0.url_string == url_string
    }
    
    if found != nil {
      
      return true
      
    } else {
      
      return false
    }
  }
  
  func remove(urlPair: UrlAndShortened_Pair) {
    
    urlPairs.removeAll {
      
      $0 == urlPair
    }
    
  }
  
  
  init(urlPairs: [UrlAndShortened_Pair]) {
    
    self.urlPairs = urlPairs
  }
}


let sampleDataStore_ForPreviews = DataStore(urlPairs: [
  
  /// I got the value from the following curl command
  /// curl https://api.shrtco.de/v2/shorten\?url=sungw.net -H "Accept: application/json"
  ///
  /// from the output JSON object
  ///{"ok":true,"result":{"code":"vjP1hj","short_link":"shrtco.de\/vjP1hj","full_short_link":"https:\/\/shrtco.de\/vjP1hj","short_link2":"9qr.de\/vjP1hj","full_short_link2":"https:\/\/9qr.de\/vjP1hj","short_link3":"shiny.link\/vjP1hj","full_short_link3":"https:\/\/shiny.link\/vjP1hj","share_link":"shrtco.de\/share\/vjP1hj","full_share_link":"https:\/\/shrtco.de\/share\/vjP1hj","original_link":"http:\/\/sungw.net"}}
  UrlAndShortened_Pair(url_string: "sungw.net", shortened_url: "https://shrtco.de/vjP1hj"),
  
  /// curl https://api.shrtco.de/v2/shorten\?url=https://sungw.net/my-portfolio -H "Accept: application/json"
  ///
  /// from the output JSON object
  ///{"ok":true,"result":{"code":"k8B6wU","short_link":"shrtco.de\/k8B6wU","full_short_link":"https:\/\/shrtco.de\/k8B6wU","short_link2":"9qr.de\/k8B6wU","full_short_link2":"https:\/\/9qr.de\/k8B6wU","short_link3":"shiny.link\/k8B6wU","full_short_link3":"https:\/\/shiny.link\/k8B6wU","share_link":"shrtco.de\/share\/k8B6wU","full_share_link":"https:\/\/shrtco.de\/share\/k8B6wU","original_link":"https:\/\/sungw.net\/my-portfolio"}}
  UrlAndShortened_Pair(url_string: "https://sungw.net/my-portfolio", shortened_url: "https://shrtco.de/k8B6wU"),
])
