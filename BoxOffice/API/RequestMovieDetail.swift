//
//  RequestMovieDetail.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/01.
//  Notification 사용

import Foundation


func requestMovieDetail(_ movieID: String, completion: @escaping (MovieDetail?) -> Void ) {
    
    print("requestMovieDetail 시작.")
    guard let url: URL = URL(string: "http://connect-boxoffice.run.goorm.io/movie?id=\(movieID)") else {
        fatalError("Making URL failed")
    }
    
    //세션 생성
    let session = URLSession(configuration: .default)
    //세션에 데이터테스트 생성
    let dataTask: URLSessionDataTask = session.dataTask(with: url) { data, response, error in
        
        print("DataTask completion handler 시작.")
        if let error = error { print(error); return }
        guard let data = data else { print("The data of data task is empty."); return }

        do {
            let movieDetail: MovieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
            completion(movieDetail)

        } catch(let err) {
            print("The JSON decoding failed")
            print(err)
            return
        }
        print("DataTask completion handler 끝.")
        
    }
    
    
    dataTask.resume()
    print("requestMovieDetail 끝 ")
    
}
