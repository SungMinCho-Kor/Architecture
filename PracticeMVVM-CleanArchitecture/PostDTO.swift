//
//  PostDTO.swift
//  PracticeMVVM-CleanArchitecture
//
//  Created by 조성민 on 12/23/23.
//

import Foundation

struct PostDTO: Decodable {
    
    let userID: Int
    let id: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id
        case title
        case body
    }
    
}
