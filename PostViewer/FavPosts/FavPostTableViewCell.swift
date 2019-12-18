//
//  FavPostTableViewCell.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit
import RxSwift

class FavPostTableViewCell: UITableViewCell {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var body: UILabel!
    

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
