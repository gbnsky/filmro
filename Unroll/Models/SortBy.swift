//
//  SortBy.swift
//  Unroll
//
//  Created by Gabriel Garcia on 14/09/23.
//

import UIKit

// MARK: - Enum

enum SortBy: String, CaseIterable {
    
    // MARK: - Cases
    
    case popularityDesc
    case popularityAsc
    case releaseDateDesc
    case releaseDateAsc
    
    // MARK: - Properties
    
    var title: String {
        switch self {
        case .popularityDesc:
            return "Popular"
        case .popularityAsc:
            return "Unpopular"
        case .releaseDateDesc:
            return "Newer"
        case .releaseDateAsc:
            return "Older"
        }
    }
    
    var query: String {
        switch self {
        case .popularityDesc:
            return "popularity.desc"
        case .popularityAsc:
            return "popularity.asc"
        case .releaseDateDesc:
            return "primary_release_date.desc"
        case .releaseDateAsc:
            return "primary_release_date.asc"
        }
    }
}
