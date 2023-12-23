//
//  ViewController.swift
//  PracticeMVVM-CleanArchitecture
//
//  Created by 조성민 on 12/21/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    private let postsSubject = PublishSubject<[PostDTO]>()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let viewReactButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "ViewButton"
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var viewModel = ViewModel(postsSubject: postsSubject)
    
    private let disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customInit()
        setUI()
        setConstraints()
        binding()
    }
    
    func customInit() {
        self.view.backgroundColor = .systemPink
    }
    
    func setUI() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(viewReactButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func binding() {
        let input = ViewModel.Input(
            viewReactButtonTap: viewReactButton.rx.tap.asObservable()
        )
        let output = viewModel.transform(input: input)
        
        output.postsOutput
            .subscribe { posts in
                dump(posts)
            }
            .disposed(by: disposableBag)
        
    }
    
}
