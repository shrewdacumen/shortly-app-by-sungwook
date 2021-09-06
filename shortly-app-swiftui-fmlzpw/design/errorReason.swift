//
//  errorReason.swift
//  errorReason
//
//  Created by sungwook on 9/6/21.
//

import Foundation



enum Enum_HttpStatusCode: Error {
  
  /// Standard REST status code
  case nonContent
  case resourceNotFoundError
  case serverError
  case unknown

}

func errorReasonREST(fromResponse response: URLResponse) throws -> Bool {
  
  guard let httpURLResponse = response as? HTTPURLResponse else {
    
    fatalError("Could NOT get HTTPURLResponse from response")
  }
  
  print("statusCode = \(httpURLResponse.statusCode)")
  
  switch httpURLResponse.statusCode {
    
  case 200-201:
    return true
    
  case 204:
    throw Enum_HttpStatusCode.nonContent
    
    
  case 404:
    throw Enum_HttpStatusCode.resourceNotFoundError
    
  case 500:
    throw Enum_HttpStatusCode.serverError
    
  default:
    throw Enum_HttpStatusCode.unknown
  }
  
}


/// shrtcode API Documentation
///
/// error_code  Error
/// 1  No URL specified ("url" parameter is empty)
/// 2  Invalid URL submitted
/// 3  Rate limit reached. Wait a second and try again
/// 4  IP-Address has been blocked because of violating our terms of service
/// 5  shrtcode code (slug) already taken/in use
/// 6  Unknown error
/// 7  No code specified ("code" parameter is empty)
/// 8  Invalid code submitted (code not found/there is no such short-link)
/// 9  Missing required parameters
/// 10  Trying to shorten a disallowed Link. More information on disallowed links

enum Enum_SHRTCODE_ErrorCode: Error {
  
  case invalidURL
  case rateLimitReached
  case shortCodeAlreadyTaken
  case IPblocked
  case urlStringEmpty
  case codeParameterEmpty
  case invalideURL
  case MissingRequiredParameters
  case disallowedLink
  case unknown
}


func errorReason_SHRTCODEWAY(fromErrorCode errorCode: Int) -> Enum_SHRTCODE_ErrorCode {
  
  switch errorCode {
    
  case 1: /// This won't happen
    return Enum_SHRTCODE_ErrorCode.urlStringEmpty
    
  case 2:
    return Enum_SHRTCODE_ErrorCode.invalidURL
    
  case 3:
    return Enum_SHRTCODE_ErrorCode.rateLimitReached

    
  case 4:
    return Enum_SHRTCODE_ErrorCode.IPblocked
    
  case 5:
    return Enum_SHRTCODE_ErrorCode.shortCodeAlreadyTaken
    
  case 6:
    return Enum_SHRTCODE_ErrorCode.unknown
    
  case 7:
    return Enum_SHRTCODE_ErrorCode.codeParameterEmpty
    
  case 8: /// this won't happen
    return Enum_SHRTCODE_ErrorCode.invalidURL
    
  case 9:
    return Enum_SHRTCODE_ErrorCode.MissingRequiredParameters
    
  case 10:
    return Enum_SHRTCODE_ErrorCode.disallowedLink
    
  default:
    return Enum_SHRTCODE_ErrorCode.unknown
  
  }
  
}
