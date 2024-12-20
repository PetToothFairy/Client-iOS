//
//  BrushingResponse.swift
//  PetToothFairy
//
//  Created by 임주민 on 12/9/24.
//

import Foundation

struct BrushingResponse: Decodable {
    let reports: [Report]
    let seq: Int
}

struct Report: Decodable {
    let name, description: String
    let percent: Double
}
