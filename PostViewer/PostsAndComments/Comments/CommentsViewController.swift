//
//  CommentsViewController.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import RxSwift

class CommentsViewController: BaseViewController, UITableViewDelegate {
    
    var disposeBag = DisposeBag()
    
    var viewModel : CommentsViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var estimatedTableCellHeight : CGFloat = 120.0
    
    var dataItems : [CommentsModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPost()
        getComments()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    //MARK:- Setup Items
    
    
    fileprivate func setupPost() {
        titleLabel.text = self.viewModel.post.title
        bodyLabel.text = self.viewModel.post.body
        favButton.isSelected = PostManager.shared.posts.filter{$0.id == self.viewModel.post.id}.first!.isFav
    }
    
    
    fileprivate func getComments() {
        let client = NetworkManager.shared
        do{
            try client.getCommentItems().subscribe(
                onNext: { result in
                    
                    self.dataItems = result.filter { $0.postId == self.viewModel.post.id }
            },
                onError: { error in
                    print(error)
            }, onCompleted: {
                
                self.setupTable()
                
            }).disposed(by: self.disposeBag)
        }
        catch{
        }
    }
    
    
    //MARK:- Setup Table
    
    
    fileprivate func setupTable() {
        DispatchQueue.main.async {
            self.tableView.estimatedRowHeight = self.estimatedTableCellHeight
            self.tableView.estimatedRowHeight = UITableView.automaticDimension
            Observable.of(self.dataItems).bind(to: self.tableView.rx.items(cellIdentifier: "commentCell", cellType: CommentTableViewCell.self)) { (row, element, cell) in
                cell.body.text = element.body
                cell.title.text = PostManager.shared.posts.filter { $0.id == element.postId }.first?.userId
            }
            .disposed(by: self.disposeBag)
            
            self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedTableCellHeight
    }
    
}
