//
//  ReactiveRequest.swift
//  PostViewer
//
//  Created by Colman Marcus-Quinn on 18.12.19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation
import RxSwift

public class RxRequest {
    private var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession
    public init(config:URLSessionConfiguration) {
        urlSession = URLSession(configuration:
            URLSessionConfiguration.default)
    }
    
    public func getPosts<ClientModel: Codable>(request: URLRequest)
        -> Observable<ClientModel> {
            return Observable.create { observer in
                let task = self.urlSession.dataTask(with: request) { (data,
                    response, error) in
                    
                    guard let httpResponse = response as? HTTPURLResponse else { return }
                    
                    let statusCode = httpResponse.statusCode
                    do {
                        let dataToTransform = data ?? Data()
                        
                        let json1 = try JSONSerialization.jsonObject(with: dataToTransform, options: .allowFragments)
                        
                        if statusCode == 200 {
                            let objs = try self.jsonDecoder.decode(ClientModel.self, from:dataToTransform)
                            observer.onNext(objs)
                        }
                        else {
                            observer.onError(error!)
                        }
                    } catch {
                        observer.onError(error)
                    }
                    
                    observer.onCompleted()
                }
                task.resume()
                return Disposables.create {
                    task.cancel()
                }
            }
    }
    
    public func getComments<CommentsModel: Codable>(request: URLRequest)
         -> Observable<CommentsModel> {
             return Observable.create { observer in
                 let task = self.urlSession.dataTask(with: request) { (data,
                     response, error) in
                     
                     guard let httpResponse = response as? HTTPURLResponse else { return }
                     
                     let statusCode = httpResponse.statusCode
                     do {
                         let dataToTransform = data ?? Data()
                         
                         let json1 = try JSONSerialization.jsonObject(with: dataToTransform, options: .allowFragments)
                         
                         if statusCode == 200 {
                             let objs = try self.jsonDecoder.decode(CommentsModel.self, from: dataToTransform)
                             observer.onNext(objs)
                         }
                         else {
                             observer.onError(error!)
                         }
                     } catch {
                         observer.onError(error)
                     }
                     
                     observer.onCompleted()
                 }
                 task.resume()
                 return Disposables.create {
                     task.cancel()
                 }
             }
     }
}
