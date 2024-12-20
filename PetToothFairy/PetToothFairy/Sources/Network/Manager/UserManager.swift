//
//  UserManager.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/5/24.
//

import Foundation
import Alamofire
import Combine

enum UserManager: URLRequestConvertible {
  case registerUser(socialAccessToken: String, petName: String, petWeight: Int)
  case getUserInfo
  case patchUserInfo(petName: String, petWeight: Int)
  
  var baseURL: URL {
    switch self {
    case .registerUser:
      return URL(string: "\(APIConstants.url)/api/register")!
    case .getUserInfo:
      return URL(string: "\(APIConstants.url)/api/home")!
    case .patchUserInfo:
      return URL(string: "\(APIConstants.url)/api/user/setinfo")!
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .registerUser:
      return .post
    case .getUserInfo:
      return .get
    case .patchUserInfo:
      return .patch
    }
  }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    headers.add(name: "Content-Type", value: "application/json")
    
    switch self {
    case .registerUser(let socialAccessToken, _, _):
      headers.add(name: "AccessToken", value: socialAccessToken)
    case .getUserInfo:
      headers.add(name: "AccessToken", value: TokenManager.accessToken ?? "")
    case .patchUserInfo:
      headers.add(name: "AccessToken", value: TokenManager.accessToken ?? "")
    }
    
    return headers
  }
  
  var body: [String: Any]? {
    switch self {
    case .registerUser(_, let petName, let petWeight):
      return [
        "petName": petName,
        "petWeight": petWeight
      ]
    case .getUserInfo:
      return nil
    case .patchUserInfo(let petName, let petWeight):
      return [
        "petName": petName,
        "petWeight": petWeight
      ]
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
