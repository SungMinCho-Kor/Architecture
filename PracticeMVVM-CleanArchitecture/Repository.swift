//
//  Repository.swift
//  PracticeMVVM-CleanArchitecture
//
//  Created by 조성민 on 12/23/23.
//

import Foundation
import Alamofire
import RxSwift

final class Repository {
    
    func fetchPosts() -> Observable<Data> {
        
        return Observable<Data>.create { emitter in
            let url = Constant.baseURL + "/posts"
            
            AF.request(url,
                       method: .get,
                       encoding: JSONEncoding(),
                       headers: [
                        "Accept": "application/json"
                       ]
            )
            .response {response in
                switch response.result {
                case .success(let data):
                    guard let data = data else { return }
                    emitter.onNext(data)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            return Disposables.create()
        }
    }
    
}
