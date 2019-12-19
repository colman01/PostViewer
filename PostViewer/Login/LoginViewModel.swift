//
//  LoginViewModel.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


class LoginViewModel {
    
    var navigationController: UINavigationController? = nil
    
    var disposeBag = DisposeBag()
    
    var userId = ""
    
    let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
    
    
    func setUseId(_ userId : Int) {
        PostManager.shared.userId = userId
    }
    
    
    func setupPostManager(_ posts : [ClientModel]) {
        PostManager.shared.posts = posts
        PostManager.shared.favPosts = posts.filter{ $0.isFav }
    }
    
    
    func getData() {
        let client = NetworkManager.shared
        do{
            try client.getPostItems().subscribe(
                onNext: { result in
                    self.setupPostManager(result.filter { $0.userId == self.userId })
                    self.showLoadingIndicator()
                    
            },
                onError: { error in
                    self.displayLoadingAlert()
            }, onCompleted: {
                
                self.displayAlertOrNavigateToPost()
                
            }).disposed(by: self.disposeBag)
        }
        catch{
        }
    }
    
    
    //MARK:- UI adn Navigation
    
    fileprivate func displayAlertOrNavigateToPost() {
        if PostManager.shared.posts.isEmpty {
            displayAlert()
        } else {
            navigateToPosts()
        }
    }
    
    
    fileprivate func showLoadingIndicator() {
        DispatchQueue.main.async {
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            
            self.alert.view.addSubview(loadingIndicator)
            self.navigationController!.present(self.alert, animated: true, completion: nil)
            
        }
    }

    
    fileprivate func navigateToPosts() {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true) {
                self.navigationController!.dismiss(animated: false, completion: nil)
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as UIViewController
                self.navigationController!.pushViewController(viewController, animated: true)
                
            }
        }
    }
    
    
    fileprivate func displayAlert() {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true) {
                self.navigationController!.dismiss(animated: false, completion: nil)
                let alertController = UIAlertController(title: "Login Failed", message: "Please try Bob,Alice,Tom,Andy or Al", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                    
                }))
                self.navigationController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func displayLoadingAlert() {
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true) {
                self.navigationController!.dismiss(animated: false, completion: nil)
                let alertController = UIAlertController(title: "Error with the Data", message: "There was a problem loading the data", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
                    
                }))
                self.navigationController?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    
}
