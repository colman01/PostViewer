//
//  CommentsViewController.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import RxSwift

class CommentsViewController: BaseViewController {
    
    var disposeBag = DisposeBag()

    var viewModel : CommentsViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var estimatedTableCellHeight : CGFloat = 120.0
    
    var dataItems : [CommentsModel] = []
    
//    tableView.estimatedRowHeight = self.estimatedTableCellHeight
//    tableView.estimatedRowHeight = UITableView.automaticDimension
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPost()
        getComments()

    }
    
    
    fileprivate func setupPost() {
        titleLabel.text = self.viewModel.post.title
        bodyLabel.text = self.viewModel.post.body
        favButton.isSelected = self.viewModel.post.isFav
    }
    
    
    func getComments() {
        let client = NetworkManager.shared
        do{
            try client.getCommentItems().subscribe(
                onNext: { result in
                    
                    self.dataItems = result.filter { $0.id == self.viewModel.post.id }
            },
                onError: { error in
                    print(error)
            }, onCompleted: {
                
                
                
            }).disposed(by: self.disposeBag)
        }
        catch{
        }
        
    }

}
