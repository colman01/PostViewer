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
    func getDataItems() throws -> Observable<[ClientModel]> {
        var request = URLRequest(url:
            URL(string:Constants.jsonAddress)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField:
            "Content-Type")
        return rxRequest.getData(request: request)
    }
}

