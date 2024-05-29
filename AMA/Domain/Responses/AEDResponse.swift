//
//  AEDResponse.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/02.
//

import Foundation

//MARK: - AEDResponse
struct AEDInfo : Decodable {
    let id: Int
    let latitude: String
    let longitude: String
    let buildPlace: String
    let buildAddress: String
    let manager: String
    let managerTel: String
    let model: String
    let col: String
}

struct AEDLocation {
    let id: Int
    let location: Location
}

struct Location {
    let latitude: String
    let longitude: String
}
