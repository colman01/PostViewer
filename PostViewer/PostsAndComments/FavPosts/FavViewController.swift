//
//  FavViewController.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import RxSwift

class FavViewController: BaseViewController, UITableViewDelegate {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    var estimatedTableCellHeight : CGFloat = 120.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItemsIntoTable()
    }
    
    
    fileprivate func setupTable() {
        tableView.estimatedRowHeight = self.estimatedTableCellHeight
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.rx
            .modelSelected(ClientModel.self)
            .subscribe(onNext:  { value in
                self.presentCommentVC(value)
            })
            .disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimatedTableCellHeight
    }
    
    fileprivate func loadItemsIntoTable() {
        if PostManager.shared.favPosts.isEmpty {
            self.tableView.isHidden = true
        } else {
            self.tableView.isHidden = false
            tableView.dataSource = nil
            Observable.just(PostManager.shared.favPosts).bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: FavPostTableViewCell.self)) { (row, element : ClientModel, cell) in
                cell.title.text =  "\(element.title)"
                cell.body.text =  "\(element.body)"
            }
            .disposed(by: disposeBag)
        }
        
    }
    
    
    func presentCommentVC(_ model : ClientModel) {
        let commentsViewModel = CommentsViewModel()
        commentsViewModel.post = model
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Comments") as! CommentsViewController
        viewController.viewModel = commentsViewModel
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
