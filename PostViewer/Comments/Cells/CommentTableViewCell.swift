//
//  CommentTableViewCell.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import RxSwift

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    
    var disposeBag = DisposeBag()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()

            disposeBag = DisposeBag()
    }

}
