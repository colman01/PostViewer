//
//  BaseViewController.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
