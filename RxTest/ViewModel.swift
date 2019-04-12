//
//  ViewModel.swift
//  RxTest
//
//  Created by Ilia on 12/04/2019.
//  Copyright © 2019 Ilia Stukalov. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewModelDelegate: class {
    func updateUI(sender: ViewModel)
}

class ViewModel: NSObject {
    weak var delegate: ViewModelDelegate?
    
    private let disposeBag = DisposeBag()
    
    var greetingsText = ""
    
    let nameSequence = PublishSubject<String>()
    
    func viewDidLoad() {
        nameSequence.subscribe { event in
            switch event {
            case .next(let value):
                self.greetingsText = "Hello, " + value + "!"
                self.delegate?.updateUI(sender: self)
            case .error(_):
                fallthrough
            case .completed:
                print(event)
            }
        }.disposed(by: disposeBag)
    }
    
}
