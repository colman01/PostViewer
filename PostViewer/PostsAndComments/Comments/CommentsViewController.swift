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
        self.view.backgroundColor = .white
        setupPost()
        setupSubsciption()
        viewModel.getComments()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    //MARK:- Setup Items
    
    
    fileprivate func setupPost() {
        titleLabel.text = self.viewModel.post.title
        bodyLabel.text = self.viewModel.post.body
        // put into model
        favButton.isSelected = self.viewModel.isFav
    }
    
    
    //MARK:- Setup Table
    
    fileprivate func setupSubsciption() {
        viewModel.itemsDownloaded.subscribe(onNext: {
        }, onError: { (Error) in
        }, onCompleted: {
            
            self.setupTable()
            
        }) {
        }.disposed(by: self.disposeBag)
    }
    
    
    fileprivate func setupTable() {
        DispatchQueue.main.async {
            
            if self.viewModel.comments.isEmpty {
                self.tableView.isHidden = true
            } else {
                self.tableView.isHidden = false
                self.tableView.estimatedRowHeight = self.estimatedTableCellHeight
                self.tableView.estimatedRowHeight = UITableView.automaticDimension
                Observable.of(self.viewModel.comments).bind(to: self.tableView.rx.items(cellIdentifier: "commentCell", cellType: CommentTableViewCell.self)) { (row, element, cell) in
                    cell.body.text = element.body
                    cell.title.text = PostManager.shared.posts.filter { $0.id == element.postId }.first?.userId
                }
                .disposed(by: self.disposeBag)
                
                self.tableView.rx.setDelegate(self).disposed(by: self.disposeBag)
            }
            
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedTableCellHeight
    }
    
}
