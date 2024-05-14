//
//  ViewModel.swift
//  AMA
//
//  Created by DwaeWoo on 2024/05/07.
//

import RxSwift

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
