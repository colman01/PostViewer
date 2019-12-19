//
//  PostModelTest.swift
//  PostViewerTests
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import XCTest
@testable import PostViewer

class PostModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModel() {
        
        let model = ClientModel(id: 1,userId: "user",title: "title", body: "body",isFav: false)
        XCTAssertEqual(model.id, 1)
        XCTAssertEqual(model.userId, "user")
        XCTAssertEqual(model.title, "title")
        XCTAssertEqual(model.body, "body")
        XCTAssertEqual(model.isFav, false)
        
    }
    
    func testCommentViewModel() {
        let viewModel = CommentsViewModel()
        let model = ClientModel(id: 1,userId: "user",title: "title", body: "body",isFav: false)
        viewModel.post = model
        let entry = viewModel.post
        XCTAssertEqual(entry?.id, 1)
        XCTAssertEqual(entry?.userId, "user")
        XCTAssertEqual(entry?.title, "title")
        XCTAssertEqual(entry?.body, "body")
        XCTAssertEqual(entry?.isFav, false)

        let comment = CommentsModel(body: "body", id: 1, postId: 1)
        viewModel.comments.append(comment)
        let viewModelComment = viewModel.comments.first
        XCTAssertEqual(viewModelComment?.id, 1)
        XCTAssertEqual(viewModelComment?.postId, 1)
        XCTAssertEqual(viewModelComment?.body, "body")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
