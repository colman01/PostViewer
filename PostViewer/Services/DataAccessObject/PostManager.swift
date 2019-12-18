//
//  PostManager.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class PostManager {
    
    var userId: Int = -1
    
    var posts: [ClientModel] = [] {
        didSet {
            favPosts = posts.filter{$0.isFav}
        }
    }
    var favPosts: [ClientModel] = []
    
    private init() {}
    
    static let shared = PostManager()
}
