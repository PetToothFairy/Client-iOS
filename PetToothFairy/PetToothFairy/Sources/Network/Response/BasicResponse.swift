//
//  BasicResponse.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/9/24.
//

import Foundation

struct BasicResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
}
