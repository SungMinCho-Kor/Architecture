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
    
    private let postsSubject: PublishSubject<[PostDTO]>
    
    init(postsSubject: PublishSubject<[PostDTO]>) {
        self.postsSubject = postsSubject
    }
    
    func react(){
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding(),
                   headers: [
                    "Accept": "application/vnd.github+json"
                   ]
        )
        .response { [weak self] response in
            switch response.result {
            case .success(let data):
                do {
                    guard let data = data else { return }
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode([PostDTO].self, from: data)
                    self?.postsSubject.onNext(posts)
                } catch let error {
                    print(error.localizedDescription)
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
