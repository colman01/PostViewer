//
//  LoginViewModel.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation


class LoginViewModel {
    
    func setUseId(_ userId : Int) {
        PostManager.shared.userId = userId
    }
    
    
}
