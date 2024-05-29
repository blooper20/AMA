//
//  MapViewModel.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/07.
//

import UIKit
import RxSwift
import RxRelay
import NMapsMap

//typealias Marker = AEDLocation

final class MapViewModel: ViewModel {
    
    var disposeBag = DisposeBag()
    let release = AEDUseCase.shared
    
    let sender = PublishRelay<NMGLatLng>()
    
    func transform(input: Input) -> Output {
        
        let markerLocation = input.viewDidLoad.flatMap { _ in
            return self.release.fetchAEDLocation()
        }
        
        let aedInfo = sender.withLatestFrom(markerLocation) { NMGLatLng, list -> Int in
            
            guard let location = list.first(where: {
                $0.location.latitude == "\(NMGLatLng.lat)" &&
                $0.location.longitude == "\(NMGLatLng.lng)"
            }) else { fatalError("Not Found ID")}
            
            return location.id
        }
        .flatMap { id in
            return self.release.fetchAEDInfo(id: id)
        }
        
        return Output(markerLocation: markerLocation, aedInfo: aedInfo)
    }
}

extension MapViewModel {
    
    //MARK: - Input
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    //MARK: - Output
    struct Output {
        let markerLocation: Observable<[AEDLocation]>
        let aedInfo: Observable<AEDInfo>
    }
}
