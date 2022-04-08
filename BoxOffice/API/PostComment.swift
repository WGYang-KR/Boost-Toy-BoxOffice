//
//  PostComment.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/08.
//

import Foundation


func postComment(_ commentToPost: CommentToPost, completion: @escaping (Bool) -> Void ) {
    
    guard let uploadData: Data = try?  JSONEncoder().encode(commentToPost) else {
        print(Error.self)
        return
    }
    
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/comment") else { return }
    
    var postRequest = URLRequest(url: url)
    postRequest.httpMethod = "POST"
    postRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let session: URLSession = URLSession(configuration: .default)
    let uploadTask: URLSessionUploadTask = session.uploadTask(with: postRequest, from: uploadData) { data, response, error in
        
        if let e = error {
            print(e)
            return
        }
        
        if let httpUrlResponse = response as? HTTPURLResponse, httpUrlResponse.statusCode == 201 {
            completion(true)
        } else {
            completion(false)
        }
        
    }
    
    uploadTask.resume()
}
