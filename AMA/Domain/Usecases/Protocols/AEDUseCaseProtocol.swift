//
//  AEDUseCaseProtocol.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/07.
//

import Foundation
import RxSwift

protocol AEDUseCaseProtocol {
    
    /// AED 전체 정보를 메모리에 저장해놓은 변수
    var aedInfos: Observable<[Info]> { get }
    
    /// AED 전체 정보를 가져옴
    func fetchAEDResponse() -> Observable<[Info]>
    
    /// Marker들의 위치 정보를 가져옴
    func fetchAEDLocation(location: Location) -> Observable<[AEDLocation]>
    
    /// id 값을 이용해 AED의 정보를 가져옴
    func fetchAEDInfo(id: String) -> Observable<Info>
}
