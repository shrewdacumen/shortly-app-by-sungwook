#  ReadMe for the Code Challenge

        Written Sep 12, 2021 by Sungwook Kim.


## Copyright (c) 2021 by Sungwook Kim
## This work is licensed under a Creative Commons Attribution-NonCommercial 4.0 International License.
## https://creativecommons.org/licenses/by-nc/4.0/
## However, anyone who has donated can use it as OPEN SOURCE with ATTRIBUTION ASSURANCE LICENSE.



## I typed all the followings in chronological order, not considering fully the integrity of ReadMe file.


## The `DEMO` movie file was included: 
  the file name: `The shortly Demo Video, Sep 12, 2021 by Sungwook.mp4`. (I reduced the size.)
  [The YouTube Video Demo](https://youtu.be/_2sPtwR8pnY)

There are two cases of the duplicate error message:

  For the 1st example: the user entered "sungw.net"  and then the app got a short code for it.
  when the user enters again "sungw.net"  even before getting access to the SHRTCODE remote endpoint,
    it will give off an error message on the overlay of text field "It is a duplicate".
    This will save the time of reaching out the remote url and getting back the shortcode that eventually
      improves the user experience.
    
  And for the 2nd example: let's say that the user entered "sungw.net".
   while he is waiting for the short code from the remote endpoint. He entered impatiently again "sungw.net".
   In this case, the duplicate message should come only after these two tasks are done.
   Because there are alway a possibility that there can be an error from the remote endpoint.
  After having processed 2 tasks, the app will return "a duplicate url" in the end only if there are 2 successful short-codes on hand.
  

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


--------------------------------------------------------------------------------------------------------

## `Additional Features` that were NOT included in the code challenge and that were added:
## or Over-Engineered Parts:

  - url validation: func validateUrl() of String extension does this.
  
      - The Error Handling version 1 (tag: The_Error_Handling_Version_1) when I didn't notice the picture `1.2_main_screen_empty_missing_link.png`.
      Because it wasn't a part of the code challenge, I'll add it with Alert view when it could not validate. 
      And please note that **[Alert](https://developer.apple.com/documentation/swiftui/alert)** is deprecated again in **SwiftUI3 (Xcode13)**, being replaced by the modifier  **alert(_:isPresented:presenting:actions:message:)**.
      As I had misunderstood the way of presenting the error message, I interpreted wrongly it to be an Alert view.
      (version 1 can be viewable when you roll back through git history by checking out.)
      
      - The Error Handling version 2 (tag: The_Error_Handling_Version_2__ConditionalTextFieldOverlayModifier )
      According to the picture '1.2_main_screen_empty_missing_link.png', I converted the corresponding view of the Lower Cell of ContentView by `ConditionalTextFieldOverlayModifier`.
      
      - `InputFieldError_Enum`, `func isValidString()` of `ContentView`, and  `ConditionalTextFieldOverlayModifier` deals with error handling of the input text on the text field:
        The reason I added feature is saving from unnecessary calling to the endpoint of SHRTCODE.
        
        For example, let say the user enter the input text "my-website/com" or "my-website_com" which are not valid url.
        instead of waiting for the result, this error handling immediately returns an error "Please enter a correct URL" on the text field without delay.
        This will surely  improve the user experience that I had to add this feature, even if there is no specification about this in the code challenge.
        
      - `ConditionalTextFieldOverlayModifier`: This is designed for displaying the error message over the text field. ( the input text field )
         and its feature is also combined with the source of truth and animation.   
  
      ### `InputFieldError_Enum` related to the above:
        1. case `.emptyString`: when the user hit the `shorten it button` without giving the text field any text. -> returns "Please add a link here" message on the overlay of text field
        2. case `invalidUrl`: when the user entered an invalid string. -> returns "Please enter a correct URL" message on the overlay of text field
        3. case `.duplicated`: when the user entered the same string again -> returns "It is a duplicate" message on the overlay of text field 

  
  - Orientation is fixed at Portrate mode.
  
  - I tried to add dark mode to the app but based on the specifications, there is no room to do that: therefore, I cancelled the previous plan.
      
  - `TheGlobalUIParameter.is_debugging_mode` controls whether it is in debugging mode or not: currently it is limited to FontTestView.
    because the project is relatively simple.
  
  - Avoided the duplicates in the text field input:
    Entering the same `url-string` will be discarded, not being added as a row but showing its error message on the TextEdit Field again as the same way as others. 
  
  - Added 'Fetching Data (n tasks)' animation when there are n connections to the remote endpoint while waiting for getting the short code from SHRTCODE.
      For example, you shall see 'Fetching Data (5 tasks)' task message animation when there are 5 connections to the SHRTCODE endpoint.
      
    Because it takes 18 seconds from S. Korea to SHRTCODE germany that I found from os logging performance testing.
    see the file `OS.log Test - URLSession 18 seconds.png` and `HTTP Traffic not enabled for iPhoneSE2.png`
    However, I could not test HTTP traffic through Instruments because my iOS devices are limited: iPhoneSE2, not iPhone12 or 11.
    
    Initially, I had been mulling over if I make multiple URLSessions to speed up the connections to the SHRTCODE endpoint. (See the Further Improvements conceived below for more.)
  
  - And when the shortcode is copied to clipboard, there is `a short 1_000ms animation` (`yellow color on the black button`) that notify the user to confirm that it is being processed as well.  `message_animation_duration of TheGlobalUIParameter`
      Because sometimes, the user may want to copy the short code again from the black button which was already copied.
      This is why I thought that such an animation (yellow text popping up) is necessary. 
      
      This is the rare case even after the short-code was copied to the clipboard, the user may want to copy it again for a reason.  
      For this very case, I added a notification animation with the yellow ‘copied’ even after the button turned already black.

      * The Place for this function: `CopyButtonView`
      
  
  - `hasNotch` property, the view modifier `AdaptivePaddingOverAllDevices`, the view `SpacerOnlyForOnlyDevicesWithoutANotch_Previews`:
    - `hasNotch` property, the view modifier `AdaptivePaddingOverAllDevices`, and `SpacerOnlyForOnlyDevicesWithoutANotch_Previews` were
      introduced to adapt the UI interfaces and elements over various iOS devices, either having a notch or without a notch.
      
      What I found from testings was as the followings:
        - iOS devices that have a notch have safeAreaInsets.bottom != 0,
        -  but iOS devices without a notch have safeAreaInsets.bottom == 0,
        On top of this, `safeAreaInsets.top behavior` or `status bar behavior` is different for iOS devices without a notch from
        those devices with a notch
        Therefore, the behavior of each UI element and animation to it will be affected accordingly.
        
        I used the full screen for the specifications of this code challenge but keyboard safe area is not controllable on SwiftUI2.0 that
        you should see an animation occurring every time the user strokes the virtual keyboard of the iOS device. However, 
        from SwiftUI3.0 this handling of the safe area was improved. Therefore, I couldn't put the feature into the project limited to SwiftUI2.0. 
        
      And from SwiftUI3.0 safeAreaInsets are more featured that we can handle this matter better.
      But as I noticed before, I sticked to SwiftUI 2.0 (Xcode 12 project setting) to make the project compatible to the current version of Xcode 
      and also viewable by the recruiter.     
      
  - Some features are designed only for testings - stability, performance, visibility like `isTesting_CustomFont`
  
  - All control parameters are consolidated in `struct TheGlobalUIParameter`.
     
  - os framework was imported and tested in logging for tracking the performance in remote web access and the corresponding sources of truth.
  
  - many debugging features like `sneakPeak_JSONObject()`
  
  - App Icon was added.
  
  - **The new feature of multiple input field attempts** while waiting for getting previous short-code from the remote endpoint: 
    And, as an example, you shall see 'Fetching Data (5 tasks)' task message animation when there are 5 connections to the SHRTCODE endpoint.
    
    And `the_total_number_of_URLSessions` is the total active URLSessions connecting to SHRTCODE endpoint: the number will change dyamically as all the active web tasks progress. 
  
    I have enabled the app to type a new input text field to fetch another short-code from the SHRTCODE endpoint even 
     during when the user is waiting for getting previous shortcoder url ( In other words, the user can type again a new url while the Fetching Data animation is still running).
     This could be done by introducing simplying a private property to each URLSession that is called `url_string_private_for_this_URLSession`.
     By the principle, this is actually multiple URLSessions because the URLSessions are being created on multi-threading. 
     
     Given the fact that fetch data from SHRTCODE to S. Korea takes 18 sec. on average that was found by the previous work of os.signpost logging,
       This feature is necessary to improve the user experience of the app.
       
     
  - And all the waiting message for URLSession shall be done by `ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView`.
  
  - `ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView`:  The Transient Error Message from the web endpoint + The Transient Task Message for adding `url_string` + Progress animation
    This is designed to give not only newly added url task information and progress animation but also 
      the error message from the remote (SHRTCODE) endpoint.
      And previously made func `errorReason_SHRTCODEWAY(fromErrorCode:)` could give the user more detail error message for the endpoint.
      However, I think that overwhelming the screen with too much information would not be pleasant to the user that I gave up using the func.
      
      And I perfectionated `ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView` in terms of multi-threading paradigm (Dispatch or GCD), as seen
       on my iOS game `Birdie's Dream`. Therefore, the programmer who haven't experienced so much in multi-threading programming may have some difficulty in
       the understanding of the multi-threading logic behind the view `ProgressInformation_Or_ErrorMessageHandling_WhileWaitingForShortCodeView`.
      
  - Upon tapping the textField, the `url_string` should be nil, in order for the user to feel comfortable.
    By this, I could improve the user experience.
```
                the_TextFeild_Object.onTapGesture {  /// Upon tap, url_string should be "" for the convenience of the user.
                  
                  url_string = ""
                }
```
  
  - The default behavior "Shorten a link here" on the TextField has been improved.
```  
  struct TheGlobalUIParameter {
  
    static let the_default_string_for_url_string_placeholder = "Shorten a link here"
  }
```


- Upon `LowerCellInputView`: When the input url gets its shortcode from the remote endpoint, it again check if there is a duplicate.

  Again, This is NOT a part of spec. of the code challenge but I need this to improve the user experience.
  
  This is necessary until this URLSession gets from the remote endpoint,
    by the logic it is impossible to determine whether it is a duplicate or not.
    Partly because there can be an error from the endpoint as well.
    
    And this can **NOT** be the state `.duplicated` of `InputFieldError_Enum`
    Because it is **NEITHER** a part of `InputFieldError_Enum`.

    
- `LowerCellInputView`: Upon the tap on the text field, the text is reset to empty.
   Otherwise, the user should delete the previously typed url string before entering a new one.
   This will improve again the user experience.
   
- DEBUG_print(_ items: Any..., separator: String = " ", terminator: String = "\n") : 
    to ease the debugging while not burdening the release app.
    
- `func set_error_message_from_the_web_endpoint(with_url_string url_string: String, errorSeriousness: Enum_ErrorSeriousNess)` on `LowerCellInputView` 
    The errors from the server will be classified as two categories.
      1. casualError_networkError -> just a network error
      2. seriousError_endPointRelocated -> only when SHRTCODE service is not available or replaced by another service.
    

    
--------------------------------------------------------------------------------------------------------
  
  
  
## Unit Testing & UI Testing
- shortly_app_swiftui_fmlzpwTests.swift: Unit Testing
- shortly_app_swiftui_fmlzpwUITests: UI Testing
  
  For Automatic UI Testing, compiler flag `XCT_UITEST` should be turned on, otherwise it does NOT work.
  (and you should uncomment the block marked XCT_UITEST on `ContentView` as well: strangely #define emulation does not work properly on Xcode 13 Beta 5.
  It maybe a bug due to being a beta version.)
  
  The example of marking in the sources. And you should uncomment the following comment to test this.
                  // MARK: XCT_UITEST "textField url_string", uncomment the following when UI Testing

      -> currently the compiler symbol XCT_UITEST is turned off.
      And you can see both on ContentView and LowerCellInputView,
```
      /// Because I can NOT use C++ style #define pragma
      /// I use the compiler flag in lieu of it.
      //#define XCT_UITEST -> compiler flag -D XCT_UITEST
``` 
  
  And due to 18 sec of running to fetch the JSON data from SHRTCODE endpoint, manual UI Testing is prefered here.
  
  These @State and modifier .accessibility(identifier: "textField url_string") may cause slow down the app that
  I commented out all of them. (Because I had UI-tested already.)
  
  ### A glitch from Xcode12 is that unit testing is still working but UI testing gives off a weird result.
  However, all testings were done chronologically that while I was working on this project step by step on Xcode 13 beta 5,
    there was no glitch.  And I also manually tested unit-testing and ui-testing as well on both the real devices and virtual devices.
    
  
## os.log & os.signpost logging

Because it takes 18 seconds from S. Korea to SHRTCODE germany that I found from os logging performance testing.
see the file `OS.log Test - URLSession 18 seconds.png` and `HTTP Traffic not enabled for iPhoneSE2.png`
However, I could not test HTTP traffic through Instruments because my iOS devices are limited: iPhoneSE2, not iPhone12 or 11.

When I try to find performance glitches or its tuning, I used to use this framework and Instruments involving Logging profiles.

  
## Thread Sanitizer
In this project, it does NOT need to include this, but I added it to test for the thread-safe.
And when I figured out that it is from another reason, I disregarded it.

I usually add TS to the project only when I use Combine and Dispatch extensively.
But this project contains scarcely Dispatch. So, it is not necessary. 
  
  
## Further improvements conceived in the design but not being attempted: 
  
  1. I found some performance issue on `LowerCellInputView` but I just postponed it: I got a 2nd jab of Corona vaccine these days. I feel so tired.
  However, the performance of the current version is relatively good.  I tried to improve readibility which I may postpone.  --> DONE.
  --> I had already solved this. 
  
  2. Additional error code handling and improve the performance URLSession and SwiftUI elements:  --> DONE
    I programmed the fundamentals in `Enum_SHRTCODE_ErrorCode`, `errorReasonREST`, `Enum_HttpStatusCode` but not utilized them all.
    Because both that SHRTCODE doesn't follow REST dissertation standard and that I don't want to add arbitrarily again add new SwiftUI element to display all 10 error codes from SHRTCODE.  Partly because I internally check the validity of the URL by validateUrl() of String extension. 
  
    - What you will see by this improvement:
      Alert (deprecated in SwiftUI3.0) or view modifier .alert can show the message when the url entered by the user violate the policy of SHRTCODE.
      or see animating SwiftUI element poping up to notify when the situation of SHRTCODE server is down or the url entered by the user violate the policy of SHRTCODE.
      
  --> I think that I had already solved this: because this does not look necessary, seeing the current user interface of the app.
  
## iOS devices and virtual devices/tools - unit-test, UI-test, performance test, profiling, thread sanitizing.
  - iPhone 12, 12 Pro Max -> Simulator
  - iPhoneSE2, iPhone6S plus -> real devices
  - iPad Pro 11.5'
  - Instruments ->Network
                ->Logging
                ->SwiftUI
  - Xcode -> Thread Sanitizer, Main Thread Checker.
                


## please note the folder `Network glitch, ownership problem, etc` for the trouble I've faced

## The simulator may give off some glitch on Xcode12, not on Xcode13. 
  Please test this project on real devices if possible.  The truth is that it depends on the bug of Xcode12.
