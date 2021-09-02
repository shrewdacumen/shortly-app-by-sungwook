//
//  UrlAndShortened_Pair.swift
//  UrlAndShortened_Pair
//
//  Created by sungwook on 9/2/21.
//

import Foundation


struct UrlAndShortened_Pair: Identifiable {
  
  let id = UUID()
  let url_string: String
  let shortened_url: String
}


class DataStore: ObservableObject {
  
  @Published var urlpairs: [UrlAndShortened_Pair]
  
  init(urlpairs: [UrlAndShortened_Pair]) {
    
    self.urlpairs = urlpairs
  }
}
