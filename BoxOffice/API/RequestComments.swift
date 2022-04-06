//
//  RequestComments.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/01.
//  handler 사용

import Foundation

func requestComments(_ movieID: String, _ completion: @escaping([Comment]) -> Void) {
    
    guard let url = URL(string: "http://connect-boxoffice.run.goorm.io/comments?movie_id=\(movieID)") else {
        print("Comments URL Error")
        return
    }
    
    let session = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url){
        data, response, error in
        
        if let error = error { print(error) ; return }
        guard let data = data else {
            print("The data is empty")
            return
        }
        
        do {
            let commentsResponse : CommentsResponse  = try JSONDecoder().decode(CommentsResponse.self, from: data)
            completion(commentsResponse.comments)
        } catch(let error) {
            print(error)
            return
            
        }
        
    }
    
    dataTask.resume()
}
