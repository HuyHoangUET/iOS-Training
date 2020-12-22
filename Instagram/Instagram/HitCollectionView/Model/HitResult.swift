//
//  HitResult.swift
//  Instagram
//
//  Created by LTT on 22/12/2020.
//

import Foundation

class HitResult: Codable {
    let total: Int
    let totalHits: Int
    let hits: [Hit]
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalHits = "totalHits"
        case hits = "hits"
    }
}
