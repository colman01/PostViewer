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
    var userId = ""
    
    @IBOutlet weak var loginButton: UIButton!
    
    var filteredPosts: [ClientModel] = []
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupTextField()
        
    }
    
    fileprivate func setupTextField() {
        userIdInputField.rx.controlEvent([.editingChanged])
        .asObservable().subscribe({ [unowned self] _ in
            self.userId = self.userIdInputField.text!
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
                        
                            self.displayAlertOrNavigateToPost()
                        
                       }).disposed(by: self.disposeBag)
                   }
                   catch{
                   }
        }, onCompleted: {
            
        }).disposed(by: self.disposeBag)
    }

    
    func displayAlertOrNavigateToPost() {
        if self.filteredPosts.isEmpty {
            displayAlert()
            
        } else {
            self.setupPostManager()
            self.navigateToPosts()
            
        }
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
    
    
    fileprivate func displayAlert() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Login Failed", message: "Please try Bob,Alice,Tom,Andy or Al", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }

}

