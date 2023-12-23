//
//  UseCase.swift
//  PracticeMVVM-CleanArchitecture
//
//  Created by 조성민 on 12/23/23.
//

import Foundation
import RxSwift

final class UseCase {
    
    private let postsSubject: PublishSubject<[PostDTO]>
    private let repository: Repository
    private let disposableBag = DisposeBag()
    
    init(postsSubject: PublishSubject<[PostDTO]>) {
        self.postsSubject = postsSubject
        self.repository = Repository(postsSubject: postsSubject)
    }
    
    func start(){
        repository.react()
    }
    
}
