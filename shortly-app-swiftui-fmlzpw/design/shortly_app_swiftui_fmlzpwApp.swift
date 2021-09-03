//
//  shortly_app_swiftui_fmlzpwApp.swift
//  shortly-app-swiftui-fmlzpw
//
//  Created by sungwook on 9/2/21.
//

import SwiftUI

@main
struct shortly_app_swiftui_fmlzpwApp: App {
  
  /// instantiating an empty data structure when the app is opened first and then it will persist.
  @StateObject var dataStore = DataStore(urlPairs: [UrlAndShortened_Pair]())
  
    var body: some Scene {
      
        WindowGroup {
          
            ContentView(dataStore: dataStore)
        }
    }
}
