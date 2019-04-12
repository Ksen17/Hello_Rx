//
//  ViewController.swift
//  RxTest
//
//  Created by Ilia on 12/04/2019.
//  Copyright © 2019 Ilia Stukalov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet var greetingsLabel: UILabel!
    @IBOutlet var textInput: UITextField!
    
    let viewModel = ViewModel()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        textInput.rx.text.filter{$0?.count ?? 0 > 0}.subscribe { event in
            switch event {
            case .next(let value):
                self.viewModel.nameSequence.onNext(value ?? "")
            case .error(_):
                fallthrough
            case .completed:
                print(event)
            }
        }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textInput.becomeFirstResponder()
    }


}

extension ViewController: ViewModelDelegate {
    func updateUI(sender: ViewModel) {
        greetingsLabel.text = sender.greetingsText
    }
}

