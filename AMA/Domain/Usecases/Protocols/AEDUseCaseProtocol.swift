//
//  AEDUseCaseProtocol.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/07.
//

import Foundation
import RxSwift

protocol AEDUseCaseProtocol {
    
    /// Marker들의 위치 정보를 가져옴
    func fetchAEDLocation() -> Observable<[AEDLocation]>
    
    /// id 값을 이용해 AED의 정보를 가져옴
    func fetchAEDInfo(id: Int) -> Observable<AEDInfo>
}
