//
//  AEDResponse.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/02.
//

import Foundation

//MARK: - AEDResponse
struct AEDResponse: Decodable {
    let data: [Info]
}

struct AEDLocation {
    let id: String
    let location: Location
}

struct Location: Decodable {
    let lat: String
    let lng: String
}

struct Info : Decodable {
    let id: String
    let location: Location
    let place: String
    let address: String
    let managerName: String
    let managerTel: String
    let modelName: String
    let manufacturer: String
}
