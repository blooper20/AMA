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
    
    var aedInfos: Observable<[Info]> {
        get {
            fetchAEDResponse()
        }
    }
    
    //MARK: - AED Info
    func fetchAEDResponse() -> Observable<[Info]> {
        return aedNetwork.fetchData().map(\.data)
    }
    
    func fetchAEDLocation(location: Location) -> Observable<[AEDLocation]> {
        
        let location = aedInfos.map { infos in
            infos.map { info in
                AEDLocation(id: info.id, location: info.location)
            }
        }
        
        return location
    }
    
    func fetchAEDInfo(id: String) -> Observable<Info> {
        
        let info = aedInfos.map { infos in
            infos.first(where: { $0.id == id })
        }.flatMap { info -> Observable<Info> in
            if let info = info {
                return .just(info)
            }
            return .error(AEDUseCaseError.invalidID)
        }
        
        return info
    }
}
