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
    var userId: Int = 2
    
    @IBOutlet weak var loginButton: UIButton!
    
    var filteredPosts: [ClientModel] = []
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTextField()
        
    }
    
    fileprivate func setupTextField() {
        userIdInputField.keyboardType = .numberPad
        userIdInputField.rx.controlEvent([.editingChanged])
        .asObservable().subscribe({ [unowned self] _ in
            self.userId = Int(self.userIdInputField.text!) ?? -1
        }).disposed(by: self.disposeBag)
    }
    
    fileprivate func setupButton() {
        self.loginButton.rx.controlEvent(.touchUpInside)
        .asDriver()
        .drive(onNext: {
            
            let client = NetworkManager.shared
                   do{
                       try client.getPostItems().subscribe(
                           onNext: { result in
                            
                            self.filteredPosts = result.filter { $0.userId == self.userId }
                       },
                           onError: { error in
                               print(error)
                       }, onCompleted: {
                        
                        if self.filteredPosts.isEmpty {
                            DispatchQueue.main.async {
                                let alertController = UIAlertController(title: "Login Failed", message: "Please try 1,2,3,4 or 5", preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                                    
                                }))
                                self.present(alertController, animated: true, completion: nil)
                            }
                            
                        } else {
                            self.setupPostManager()
                            self.navigateToPosts()
                            
                        }
                        
                       }).disposed(by: self.disposeBag)
                   }
                   catch{
                   }
        }, onCompleted: {
            
        }).disposed(by: self.disposeBag)
    }

    
    func setupPostManager() {
        PostManager.shared.posts = self.filteredPosts
        PostManager.shared.favPosts = self.filteredPosts.filter{ $0.isFav }
    }
    
    fileprivate func navigateToPosts() {
        DispatchQueue.main.async {
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as UIViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }

}

