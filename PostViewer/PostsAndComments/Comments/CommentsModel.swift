//
//  CommentsModel.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct CommentsModel : Codable {
    var body: String
    var id: Int
    var postId: Int
    
    
    init(body: String, id: Int, postId: Int) {
        self.body = body
        self.id = id
        self.postId = postId
    }
}
