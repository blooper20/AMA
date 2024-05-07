//
//  Networks.swift
//  AMA
//
//  Created by DwaeWoo on 2024/04/02.
//

import Foundation
import RxSwift

final class Networks {
    
    static let shared = Networks()
    
    private init() {}
    
    //MARK: - URL Components
    let urlComponent = "https://api.manana.kr/v2/karaoke/"
    
    //MARK: - Path
    let search = "search.json?"
}

extension Networks {
    
    func getURL() -> String {
        
        let url = urlComponent + search
        
        return url
    }
    
    func getData(url: String) -> Observable<AEDResponse> {
        return Observable.create { observer in
            guard let url = URL(string: url) else {
                observer.onError(NSError(domain: "Invalid URL", code: 0))
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    observer.onError(NSError(domain: "Invalid Response", code: 0))
                    return
                }
                
                do {
                    if let data = data {
                        let decodedData = try JSONDecoder().decode(AEDResponse.self, from: data)
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
    }
}
