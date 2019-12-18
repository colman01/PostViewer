//
//  CommentsViewController.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class CommentsViewController: BaseViewController {

    var viewModel : CommentsViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var estimatedTableCellHeight : CGFloat = 120.0
    
//    tableView.estimatedRowHeight = self.estimatedTableCellHeight
//    tableView.estimatedRowHeight = UITableView.automaticDimension
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPost()

    }
    
    
    fileprivate func setupPost() {
        titleLabel.text = self.viewModel.post.title
        bodyLabel.text = self.viewModel.post.body
        favButton.isSelected = self.viewModel.post.isFav
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
