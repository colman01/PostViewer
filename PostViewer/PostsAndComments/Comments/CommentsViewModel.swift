//
//  CommentsViewModel.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
import RxSwift

class CommentsViewModel {
    var post : ClientModel! {
        didSet {
            isFav = PostManager.shared.posts.filter{$0.id == post.id}.first!.isFav
        }
    }
    
    var isFav:Bool = false
    
    var comments: [CommentsModel] = []
    
    var disposeBag = DisposeBag()
    
    let itemsDownloaded = PublishSubject<()>()
    
    
    func getComments() {
        let client = NetworkManager.shared
        do{
            try client.getCommentItems().subscribe(
                onNext: { result in
                    
                    self.comments = result.filter { $0.postId == self.post.id }
            },
                onError: { error in
                    print(error)
            }, onCompleted: {

                self.itemsDownloaded.onCompleted()
                
            }).disposed(by: self.disposeBag)
        }
        catch{
        }
    }
    
}
