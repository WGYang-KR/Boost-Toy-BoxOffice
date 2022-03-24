//
//  DownData.swift
//  BoxOffice
//  영화정보 다운로드
//  Created by WG Yang on 2022/03/24.
//

import Foundation

func requestMovies(orderType: Int)-> [Movie]? {
    
    var result: [Movie]? //다운 목록
    
    guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=\(orderType)")
    else { print("MOVIES API URL ERROR")
        return nil
    }
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
            
            result = moviesResponse.movies
          
        } catch(let err) {
            print("JSON DECODE ERROR")
            print(err)
        }
  
    }
    
    dataTask.resume()
    print(result)
    return result
}
