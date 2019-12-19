//
//  ViewController.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var userIdInputField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    var viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTextField()
        viewModel.navigationController = self.navigationController
    }
    
    
    fileprivate func setupTextField() {
        userIdInputField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ [unowned self] _ in
                self.viewModel.userId = self.userIdInputField.text!
            }).disposed(by: self.disposeBag)
    }
    
    fileprivate func setupButton() {
        self.loginButton.rx.controlEvent(.touchUpInside)
            .asDriver()
            .drive(onNext: {
                self.viewModel.getData()
            }, onCompleted: {
                
            }).disposed(by: self.disposeBag)
    }

}

