//
//  ViewModel.swift
//  PracticeMVVM-CleanArchitecture
//
//  Created by 조성민 on 12/21/23.
//

import Foundation
import RxSwift
import RxCocoa

final class ViewModel {
    
    private let disposableBag = DisposeBag()
    
    private let postsSubject: PublishSubject<[PostDTO]>
    
    private let usecase = UseCase()
    
    init(postsSubject: PublishSubject<[PostDTO]>) {
        self.postsSubject = postsSubject
    }
    
    func transform(input: ViewModel.Input) -> ViewModel.Output {
        input.viewReactButtonTap
            .bind { [weak self] _ in
                guard let self = self else { return }
                
                self.usecase.start()
                    .subscribe(
                        onNext: { posts in
                            self.postsSubject.onNext(posts)
                        },
                        onError: { error in
                            dump(error)
                        }
                    )
                    .disposed(by: self.disposableBag)
            }
            .disposed(by: disposableBag)
        
        return Output(
            postsOutput: postsSubject.asObservable()
        )
    }
    
}

extension ViewModel {
    
    struct Input {
        let viewReactButtonTap: Observable<Void>
    }
    
    struct Output {
        let postsOutput: Observable<[PostDTO]>
    }
    
}
