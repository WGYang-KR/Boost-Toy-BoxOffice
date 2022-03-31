//
//  Movie.swift
//  BoxOffice
//  Movies, Movie 구조체
//  Created by WG Yang on 2022/03/24.
//

import Foundation


struct MoviesResponse: Codable {
    let order_type: Int
    let movies: [Movie]
}

struct Movie: Codable {
    let grade: Int // 0: 전체 , 12: 12세, 15: 15세, 19: 19세
    let thumb: String //포스터 이미지 썸네일 주소
    let reservation_grade: Int //예매순위
    let title: String //영화제목
    let reservation_rate: Double //예매율
    let user_rating: Double //사용자 평점
    let date: String //개봉일
    let id: String //영화 고유id
    
    var tableRateString: String {
        return "평점: \(user_rating) 예매순위: \(reservation_grade) 예매율: \(reservation_rate)"
    }
    var tableDateString: String {
        return "개봉일: \(date)"
    }
    
}
