//
//  ClientModel.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

public struct ClientModel: Codable {
    var id: Int
    var userId: String
    var title: String
    var body: String
    var isFav: Bool
    
    init(id: Int, userId: String, title: String, body: String, isFav: Bool) {
        self.id = id
        self.userId = userId
        self.title = title
        self.body = body
        self.isFav = isFav
    }
    
}
