//
//  CommentToPost.swift
//  BoxOffice
//
//  Created by WG Yang on 2022/04/08.
//

import Foundation

struct CommentToPost: Codable {
    
    let rating: Double //평점
    let writer: String //작성자
    let movieID: String //영화 고유ID
    let contents: String // 한줄평 내용

    enum CodingKeys: String, CodingKey {
        case rating, writer, contents
        case movieID = "movie_id"
    }
}
