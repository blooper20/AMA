//
//  AEDNetwork.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/02.
//

import Foundation
import RxSwift

final class AEDNetwork {
    
    static let shared = AEDNetwork()
    
    private init() {}
    
    //MARK: - URL Components
    let urlComponent = "https://ce53-219-250-217-58.ngrok-free.app/api/aed"
}

extension AEDNetwork {
    
    func fetchData() -> Observable<[AEDInfo]> {
        return Observable.create { observer in
            guard let url = URL(string: self.urlComponent) else {
                observer.onError(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(NSError(domain: "Invalid Response", code: 0, userInfo: nil))
                    return
                }
                
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode([AEDInfo].self, from: data)
                        observer.onNext(decodedData)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(error)
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
}
