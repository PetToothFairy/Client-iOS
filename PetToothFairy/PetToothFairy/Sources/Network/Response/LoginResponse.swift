//
//  LoginResponse.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/12.
//

import Foundation

struct LoginResponse: Decodable {
  let status: Int
  let body: String?
  let data: TokensResponse?
}

struct TokensResponse: Decodable {
  let accessToken, refreshToken: String
  
  enum CodingKeys: String, CodingKey {
    case accessToken = "AccessToken"
    case refreshToken = "RefreshToken"
  }
}
