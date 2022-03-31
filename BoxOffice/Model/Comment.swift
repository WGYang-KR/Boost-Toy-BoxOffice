//
//  Comment.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/01.
//

import Foundation

struct CommentsResponse: Codable {
    let comments: Comment
}

struct Comment: Codable {
    let rating: Double //평점
    let timestamp: Double //작성일시 UNIX Timestamp 값
    let writer: String //작성자
    let movie_id: String //영화 고유ID
    let contents: String //한줄평 내용
    let id: String //한줄평 고유ID
}
