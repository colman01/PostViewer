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
    
    
    fileprivate func setupTable() {
        tableView.estimatedRowHeight = self.estimatedTableCellHeight
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        Observable.of(PostManager.shared.posts).bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: PostTableViewCell.self)) { (row, element, cell) in
            self.configCell(cell, element, row)
        }
        .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(ClientModel.self)
            .subscribe(onNext:  { value in
                self.presentCommentVC(value)
            })
            .disposed(by: disposeBag)
        
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    
    fileprivate func configCell(_ cell: PostTableViewCell,_ element: ClientModel, _ row: Int) {
        cell.title.text =  "\(element.title)"
        cell.body.text =  "\(element.body)"
        cell.favButton.isSelected = element.isFav
        
        cell.favButton.rx.controlEvent(.touchUpInside)
            .asDriver()
            .drive(onNext: { (_) in
                var item = PostManager.shared.posts[row]
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
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
