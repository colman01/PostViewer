//
//  NetworkManger.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class NetworkManager {
    static var shared = NetworkManager()
    lazy var rxRequest = RxRequest(config: .default)
    
    
    func getPostItems() throws -> Observable<[ClientModel]> {
        var request = URLRequest(url:
            URL(string:Constants.jsonPostsAddress)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:
            "Content-Type")
        return rxRequest.getPosts(request: request)
    }
    
    
    func getCommentItems() throws -> Observable<[CommentsModel]> {
        var request = URLRequest(url:
            URL(string:Constants.jsonCommentsAddress)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:
            "Content-Type")
        return rxRequest.getComments(request: request)
    }
}

