//
//  Comment.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/01.
//

import Foundation
/*
 
{
comments: [
{
id: "5d5e09241b865e00110ab5eb",
rating: 10,
timestamp: 1515748870.80631,
writer: "두근반 세근반",
movie_id: "5a54c286e8a71d136fb5378e",
contents:"정말 다섯 번은 넘게 운듯 ᅲᅲᅲ 감동 쩔어요.꼭 보셈 두 번 보셈"
}, {
contents: "한국형 영화입니다~이런류좋아하시는분은무조건재밌다합니다~전요번년도 세손가락에꼽히는 영화네요~굿잡~"
} ]
}
 */
struct CommentsResponse: Codable {
    let comments: [Comment]
}

struct Comment: Codable {
    let rating: Double //평점
    let timestamp: Double //작성일시 UNIX Timestamp 값
    let writer: String //작성자
    let movie_id: String //영화 고유ID
    let contents: String //한줄평 내용
    let id: String //한줄평 고유ID
    
    var dateTimeDescription: String {
        let date = Date(timeIntervalSince1970: self.timestamp)
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dataFormatter.string(from: date)
    }
}
