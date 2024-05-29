//
//  AEDUseCase.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/02.
//

import Foundation
import RxSwift

enum AEDUseCaseError: Error {
    case invalidID
}

final class AEDUseCase {
    
    static let shared = AEDUseCase()
    let disposeBag = DisposeBag()
    
    let aedNetwork = AEDNetwork.shared
}

extension AEDUseCase: AEDUseCaseProtocol {
    
    //MARK: - AED Info
    func fetchAEDLocation() -> Observable<[AEDLocation]> {
        
        let location = aedNetwork.fetchData().map { infos in
            infos.map { info in
                AEDLocation(id: info.id, location: .init(latitude: info.latitude, longitude: info.longitude))
            }
        }
        
        return location
    }
    
    func fetchAEDInfo(id: Int) -> Observable<AEDInfo> {
        
        let info = aedNetwork.fetchData().map { infos in
            infos.first(where: { $0.id == id })
        }.flatMap { info -> Observable<AEDInfo> in
            if let info = info {
                return .just(info)
            }
            return .error(AEDUseCaseError.invalidID)
        }
        
        return info
    }
}
