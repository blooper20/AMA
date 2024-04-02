//
//  UseCase.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/02.
//

import Foundation
import RxSwift

final class UseCase {
    
    static let shared = UseCase()
    let disposeBag = DisposeBag()
    
    let networks = Networks.shared
    
}

extension UseCase {
    
    //MARK: - Title
//    func getSearching(brand: String, text: String) -> Observable<SongsResponse> {
//        return networks.getData(url: self.networks.getSearchURL() + "brand=\(brand)&\(text)")
//    }
}
