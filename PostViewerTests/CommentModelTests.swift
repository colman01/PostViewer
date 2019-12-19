//
//  CommentModelTests.swift
//  PostViewerTests
//
//  Created by Colman Marcus-Quinn on 19.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import XCTest
@testable import PostViewer

class CommentModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsNotFavourite() {
        let viewModel = CommentsViewModel()
        let post = ClientModel(id: 1,userId: "user",title: "title", body: "body",isFav: false)
        PostManager.shared.posts.append(post)
        viewModel.post = PostManager.shared.posts.first
        XCTAssertFalse(viewModel.isFav)
    }
    
    func testIsFavourite() {
        let viewModel = CommentsViewModel()
        let post = ClientModel(id: 1,userId: "user",title: "title", body: "body",isFav: true)
        PostManager.shared.posts.append(post)
        viewModel.post = PostManager.shared.posts.first
        XCTAssertTrue(viewModel.isFav)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
