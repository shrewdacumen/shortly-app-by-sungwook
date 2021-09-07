//
//  sneakPeak_JSONObject.swift
//  sneakPeak_JSONObject
//
//  Created by sungwook on 9/6/21.
//

import Foundation




func sneakPeak_JSONObject(_ jsonObject: Any) {
  
  switch jsonObject {
  
  case is Dictionary<String, Any>:
    
    print("""
      dic.keys=
      \((jsonObject as! Dictionary<String, Any>).keys)
      """)
    
  case is Array<Any>:
    
    (jsonObject as! Array<Any>).forEach {
      
      if $0 as? String != nil {
        
        print($0)
      }
    }
    
  default:
    break
  }
  
  print("""
    jsonObject =
    \(jsonObject)
    """)
  
}
