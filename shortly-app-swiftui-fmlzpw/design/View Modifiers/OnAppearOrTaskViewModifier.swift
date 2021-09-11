//
//  OnAppearOrTaskViewModifier.swift
//  OnAppearOrTaskViewModifier
//
//  Created by sungwook on 9/10/21.
//

import SwiftUI


struct OnAppearOrTaskViewModifier: ViewModifier {
  
  let action: (() -> Void)
  
  func body(content: Content) -> some View {
    
    #if swift(>=5.5)
    
    if #available(iOS 15.0, *) {
      
      content.task { /// @escaping
        
        action()
        
      }
      
    } else {
      
      content.onAppear { /// putting non-escaping closure into @escaping closure has no issue.
        
        action()
      }
      
    }
    
    #else
    
    content.onAppear { /// putting non-escaping closure into @escaping closure has no issue.
      
      action()
    }
    
    #endif
    
    
  }
  
}
  
  
  extension View {
    
    func onAppearOrTask(perform: @escaping (() -> Void)) -> some View {
      
      modifier(OnAppearOrTaskViewModifier { perform() })
    }
  }
  
  

/// ** PLAN A **
/// extension View {
///
///   func onAppearOrTask(perform action: (() -> Void)? = nil) -> some View {
///
///     guard let action = action else {
///
///       return self
///     }
///
///     if #available(iOS 15.0, *) {
///
///       return self.task {
///
///         action()
///
///         print("stop")
///       }
///
///     } else {
///
///       return self.onAppear {
///
///         action()
///
///         print("stop")
///       }
///     }
///
///   }
/// }

