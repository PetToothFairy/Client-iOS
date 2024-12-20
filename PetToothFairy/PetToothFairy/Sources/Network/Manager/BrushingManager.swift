//
//  LoginManager.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/12.
//

import Foundation
import Alamofire
import Combine

enum BrushingManager: URLRequestConvertible {
  
  case getBrushingResults(accessToken: String, receivedArray: [String])
  
  var baseURL: URL {
    switch self {
    case .getBrushingResults:
      return URL(string: "\(APIConstants.url)/api/tooth")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .getBrushingResults:
      return .post
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    
    switch self {
    case .getBrushingResults(let accessToken, _):
      headers.add(name: "Content-Type", value: "application/json")
      headers.add(name: "AccessToken", value: accessToken)
    }
    
    return headers
  }
  
  var body: [Any]? {
    switch self {
    case .getBrushingResults(_, let receivedArray):
      return receivedArray
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = baseURL
    var request = URLRequest(url: url)
    request.method = method
    request.headers = headers
    
    if let body = body {
      request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
    }
    
    return request
  }
}
