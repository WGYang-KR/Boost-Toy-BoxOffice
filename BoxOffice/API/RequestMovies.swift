//
//  DownData.swift
//  BoxOffice
//  영화목록 다운로드
//  Created by WG Yang on 2022/03/24.
//  Notification 사용

import Foundation

let DidReceiveMoviesNotification: Notification.Name = Notification.Name("DisReceiveMovies")

enum OrderType: Int {
    case reservationRate //예매율
    case curation //추천순
    case date //개봉일순
}

func orderTypeDescription(_ orderType :OrderType) -> String {
    switch orderType {
    case .reservationRate:
        return "예매율순"
    case .curation:
        return "추천순"
    case .date:
        return "개봉일순"
    }
}

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
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Response Status Code: \(httpResponse.statusCode)")
            }
            
            do { let moviesResponse: MoviesResponse
                = try JSONDecoder().decode(MoviesResponse.self, from: data)
                
                print("DataTask Handler: JSON DECODE 완료")
                NotificationCenter.default.post(name: DidReceiveMoviesNotification, object: nil, userInfo: ["movies": moviesResponse.movies])
              
            } catch(let err) {
                print("JSON DECODE ERROR")
                print(err)
            }
      
        }
        
        dataTask.resume()
    }
}

