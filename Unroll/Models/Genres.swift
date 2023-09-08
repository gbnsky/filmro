//
//  Genres.swift
//  Unroll
//
//  Created by Gabriel Garcia on 08/09/23.
//

struct Genres: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
