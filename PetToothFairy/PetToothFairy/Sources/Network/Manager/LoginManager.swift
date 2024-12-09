//
//  LoginManager.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/12.
//

import Foundation
import Alamofire
import Combine

enum LoginManager: URLRequestConvertible {
  
  case postkakaoLogin(accessToken: String)
  
  var baseURL: URL {
    switch self {
    case .postkakaoLogin:
      return URL(string: "\(APIConstants.url)/api/login")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .postkakaoLogin:
      return .get
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    
    switch self {
    case .postkakaoLogin(let accessToken):
      headers.add(name: "Content-Type", value: "application/json")
      headers.add(name: "AccessToken", value: accessToken)
    }
    
    return headers
  }
  
  var body: [String: Any]? {
    switch self {
    case .postkakaoLogin:
      return nil
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
