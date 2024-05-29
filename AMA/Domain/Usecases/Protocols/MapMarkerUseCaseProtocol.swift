//
//  MapMarkerUseCaseProtocol.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/07.
//

import Foundation
import RxSwift

protocol MapMarkerUseCaseProtocol {
    
    /// Location 주변 Marker들의 위치 정보를 가져옴
    func fetchAroundMarker(location: AEDLocation)
}
