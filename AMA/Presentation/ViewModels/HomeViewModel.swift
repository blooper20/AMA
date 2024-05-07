//
//  HomeViewModel.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/07.
//

import UIKit
import RxSwift

final class HomeViewModel: ViewModel {
    
    var disposeBag = DisposeBag()
    let release = UseCase.shared
    
    
    func transform(input: Input) -> Output {
        
        let aedInfo = input.viewDidLoad.flatMap { _ in
            return self.release.getAED(location: "")
        }
        .map { response in
            return response.data
        }
        
        return Output(aedInfo: aedInfo)
    }
}

extension HomeViewModel {
    
    //MARK: - Input
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    //MARK: - Output
    struct Output {
        let aedInfo: Observable<[Info]>
    }
}
