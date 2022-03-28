//
//  DownData.swift
//  BoxOffice
//  영화정보 다운로드
//  Created by WG Yang on 2022/03/24.
//

import Foundation

let DidReceiveMoviesNotification: Notification.Name = Notification.Name("DisReceiveMovies")


func requestMovies(orderType: Int) {
        
    if let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=\(orderType)") {
    
        print(url)
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask
        = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("에러 dataTask 핸들러")
                print(error)
                return
            }
            
            guard let data = data else {
                print("에러 dataTask에서 data 안넘어옴")
                return
            }
            
            do { let moviesResponse: MoviesResponse
                = try JSONDecoder().decode(MoviesResponse.self, from: data)
                
                NotificationCenter.default.post(name: DidReceiveMoviesNotification, object: nil, userInfo: ["movies": moviesResponse.movies])
              
            } catch(let err) {
                print("JSON DECODE ERROR")
                print(err)
            }
      
        }
        
        dataTask.resume()
    }
}

