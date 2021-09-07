#  ReadMe for the Code Challenge

## refer to the folder `Network glitch, ownership problem, etc` for the trouble I've faced


## My Environment Xcode 13 beta 5 (Not Xcode 12): SwiftUI3 capable.
I'm using **Swift3**, the latest one which is included only in **Xcode 13 Beta 5**.
in order to maximize the ability I have been using Xcode 13 beta 5 (SwiftUI3)
However, for the compatibility I had to lower the version to Xcode 12 (SwiftUI2) where many feature are deprecated already.

The problem is that On Xcode 12 Info.plist is continually giving me a strange error that is not acutally error:
  It compiles well and test well, but gives a false error.
However, On Xcode 13, I have no such issue: I have no choice because I should stick to Xcode 12 to make my project accessible by the company.

## Some functions and features will be different from the stable version Xcode 12 as the followings:
  - all the asynchronous async, await feature of SwiftUI3 is not available (I'll try not to use this, even if I knew these things well.)
  - popular functions like `func overlay<Overlay>(_ overlay: Overlay, alignment: Alignment = .center) -> some View where Overlay : View` is replaced by 
     func overlay<V>(alignment: Alignment = .center, content: () -> V) -> some View where V : View in SwiftUI3.0 (Xcode13 beta)
  - I am tempted or accustomed to use asynchronous task(priority:_:) modifier than on the synchronous onAppear(perform:), but I try not to: for the compatibility to **Xcode 12** 
    which is limited to **Swift2.0**.

Therefore, sometimes unknowingly, I may use the **SwiftUI3** functions and modifiers: if this happens, the project even in the format of Xcode 12 won't be compiled but **Xcode 13 beta 5**. However, I will try to uae the deprecated function if possible.  If that happens unknowingly, please download **Xcode 13 beta 5** from developer.apple.com and then compile the project, instead.

Because I'm downgrade the project to Xcode12 project format, there are some bugs involved in Info.plist but it is a glitch. It will compile and run without problem. Xcode 12 compiler may keep giving you an error message for the missing Info.plist but it is an expected bug in Xcode 12.
If you created the project on Xcode 13, it won't happen.  However, in order to maintain compatibility with Xcode 12, I intentionally created the project in Xcode 12 format.  (Xcode 13, Info.plist disappear and are consolidated to project settings.) 


## `Additional Features` that were NOT included in the code challenge and that were added:

  - url validation: func validateUrl() of String extension does this.
  
      - The Error Handling version 1 (tag: The_Error_Handling_Version_1) when I didn't notice the picture `1.2_main_screen_empty_missing_link.png`.
      Because it wasn't a part of the code challenge, I'll add it with Alert view when it could not validate. 
      And please note that **[Alert](https://developer.apple.com/documentation/swiftui/alert)** is deprecated again in **SwiftUI3 (Xcode13)**, being replaced by the modifier  **alert(_:isPresented:presenting:actions:message:)**.
      As I had misunderstood the way of presenting the error message, I interpreted wrongly it to be an Alert view.
      
      - The Error Handling version 2 (tag: The_Error_Handling_Version_2__ConditionalTextFieldOverlayModifier )
      According to the picture '1.2_main_screen_empty_missing_link.png', I converted the corresponding view of the Lower Cell of ContentView by `ConditionalTextFieldOverlayModifier`.
      
  - The returned state of 'input' field empty shall be treated in the same way but with a different error message.
  
  - Orientation is fixed at Portrate mode.
  
  - I tried to add dark mode to the app but based on the specifications, there is no room to do that: therefore, I cancelled the previous plan.
      
  - TheGlobalUIParameter.is_debugging_mode controls whether it is in debugging mode or not.
  
  - Entering the same `url-string` will be discarded, not being added as a row but showing its error message on the TextEdit Field again as the same way as others. 
  
  - Added 'Fetching Data' animation while waiting for getting the short code from SHRTCODE.
  
  - And when the shortcode is copied to clipboard, there is a short 1_000ms animation (yellow color on the black button) that notify the user to confirm it as well.
  
  - hasNotch property was introduced to adapt the UI interfaces and elements over various iOS devices.
    What I found was as the followings:
      - iOS devices that have a notch have safeAreaInsets.top != 0,
      -  but iOS devices that have a notch have safeAreaInsets.top == 0,
      Therefore, the behavior of each UI element and animation to it will be affected accordingly.
      
  - Some features are designed only for testings - stability, performance, visibility like `isTesting_CustomFont`
  
  - All control parameters are consolidated in `struct TheGlobalUIParameter`.
  
  - `conditionalOverlay`: This is designed for displaying the error message over the text field. ( the input text field )
     and its feature is also combined with the source of truth and animation.
  
  
## Further improvements conceived in the design but not being attempted: 
  1. I didn’t make multiple URLSessions for multi-threaded inputs.  Even if this will improve user experience but I thought that the code challenge does not want such things.  It is over-engineering for code challenge.  If this is an actual work I may have to add the feature.
     I am sure that my expertise in Combine and Dispatch (GCD) or multi-threaded design/programming will help improve the user experience.
   
    - What functions of the app will change by this improvement: 
    instant typings of multiple urls without having to wait for getting the shortcode from the slow SHRTCODE server. 
  
  2. I found some performance issue on `LowerCellInputView` but I just postponed it: I got a 2nd jab of Corona vaccine these days. I feel so tired.
  However, the performance of the current version is relatively good.  I tried to improve readibility which I may postpone.
  
  
  ## Tested iOS devices:
  iPhone 12, 12 max -> Simulator
  iPhoneSE2, iPhone6S plus -> real devices
  iPad Pro 11.5'
