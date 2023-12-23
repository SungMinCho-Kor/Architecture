//
//  ViewModel.swift
//  PracticeMVVM-CleanArchitecture
//
//  Created by 조성민 on 12/21/23.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class ViewModel {
    
    private let disposableBag = DisposeBag()
    
    private let postsSubject: PublishSubject<[PostDTO]>
    
    private lazy var usecase = UseCase(postsSubject: postsSubject)
    
    init(postsSubject: PublishSubject<[PostDTO]>) {
        self.postsSubject = postsSubject
    }
    
    func transform(input: ViewModel.Input) -> ViewModel.Output {
        
        input.viewReactButtonTap
            .bind { [weak self] _ in
                self?.usecase.start()
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
