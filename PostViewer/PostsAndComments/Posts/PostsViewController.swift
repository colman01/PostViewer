//
//  PostsViewController.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: BaseViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var estimatedTableCellHeight : CGFloat = 120.0
    
    var disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    fileprivate func setupTable() {
        tableView.estimatedRowHeight = self.estimatedTableCellHeight
        tableView.estimatedRowHeight = UITableView.automaticDimension
        loadItemsIntoTable()
        tableView.rx
            .modelSelected(ClientModel.self)
            .subscribe(onNext:  { value in
                self.presentCommentVC(value)
            })
            .disposed(by: disposeBag)
        
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    fileprivate func loadItemsIntoTable() {
        tableView.dataSource = nil
        Observable.just(PostManager.shared.posts).bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: PostTableViewCell.self)) { (row, element : ClientModel, cell) in
            self.configCell(cell, element, row)
        }
        .disposed(by: disposeBag)

    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedTableCellHeight
    }
    
    
    fileprivate func configCell(_ cell: PostTableViewCell,_ element: ClientModel, _ row: Int) {
        cell.title.text =  "\(element.title)"
        cell.body.text =  "\(element.body)"
        cell.favButton.isSelected = element.isFav
        
        cell.favButton.rx.controlEvent(.touchUpInside)
            .asDriver()
            .drive(onNext: { (_) in
                if cell.favButton.isSelected {
                    cell.favButton.isSelected = false
                    PostManager.shared.posts[row].isFav = false
                } else {
                    cell.favButton.isSelected = true
                    PostManager.shared.posts[row].isFav = true
                }
            }, onCompleted: {
                
            }).disposed(by: self.disposeBag)
        
    }
    
    
    func presentCommentVC(_ model : ClientModel) {
        let commentsViewModel = CommentsViewModel()
        commentsViewModel.post = model
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Comments") as! CommentsViewController
        viewController.viewModel = commentsViewModel
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    



}
