//
//  LoginResponse.swift
//  PetToothFairy
//
//  Created by 임주민 on 2024/11/12.
//

import Foundation

struct TokensResponse: Decodable {
  let accessToken: String?
  let refreshToken: String?
}
