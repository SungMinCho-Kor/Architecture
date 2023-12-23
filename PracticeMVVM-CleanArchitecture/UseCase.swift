//
//  UseCase.swift
//  PracticeMVVM-CleanArchitecture
//
//  Created by 조성민 on 12/23/23.
//

import Foundation
import RxSwift

final class UseCase {
    
    private let disposableBag = DisposeBag()
    private let repository = Repository()
    
    func start() -> Observable<[PostDTO]> {
        
        return Observable<[PostDTO]>.create { [weak self] emitter in
            guard let self = self else { return Disposables.create() }
            
            self.repository.fetchPosts().subscribe { data in
                do {
                    let decoder = JSONDecoder()
                    let posts = try decoder.decode([PostDTO].self, from: data)
                    emitter.onNext(posts)
                } catch let error {
                    dump(error)
                }
            }
            .disposed(by: self.disposableBag)
            
            
            return Disposables.create()
        }
    }
    
}
