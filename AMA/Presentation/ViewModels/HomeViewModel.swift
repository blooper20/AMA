//
//  HomeViewModel.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/07.
//

import UIKit
import RxSwift

//typealias Marker = AEDLocation

final class HomeViewModel: ViewModel {
    
    var disposeBag = DisposeBag()
    let release = AEDUseCase.shared
    
    func transform(input: Input) -> Output {
        
        let markerLocation = input.viewDidLoad.flatMap { _ in
            return self.release.fetchAEDLocation(location: .init(lat: "", lng: ""))
        }.map { aedLocations in
            aedLocations.map { aedLocation in
                aedLocation.location
            }
        }
        
        let aedInfo = input.tapMarker.flatMap { _ in
            return self.release.fetchAEDInfo(id: "")
        }
        
        //FIXME: - 추후
        let currentCenterPoint = input.didMoveCenterPoint
        
        return Output(markerLocation: markerLocation, aedInfo: aedInfo, currentCenterPoint: currentCenterPoint)
    }
}

extension HomeViewModel {
    
    //MARK: - Input
    struct Input {
        let viewDidLoad: Observable<Void>
        let tapMarker: Observable<Void>
        let didMoveCenterPoint: Observable<Location>
    }
    
    //MARK: - Output
    struct Output {
        let markerLocation: Observable<[Location]>
        let aedInfo: Observable<Info>
        let currentCenterPoint: Observable<Location>
    }
}
