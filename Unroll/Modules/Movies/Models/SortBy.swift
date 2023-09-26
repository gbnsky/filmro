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
    case releaseDateDesc
    case popularityAsc
    case releaseDateAsc
    
    // MARK: - Properties
    
    var title: String {
        switch self {
        case .popularityDesc:
            return "Popular".localized()
        case .releaseDateDesc:
            return "Newer".localized()
        case .popularityAsc:
            return "Unpopular".localized()
        case .releaseDateAsc:
            return "Older".localized()
        }
    }
    
    var query: String {
        switch self {
        case .popularityDesc:
            return "popularity.desc"
        case .releaseDateDesc:
            return "primary_release_date.desc"
        case .popularityAsc:
            return "popularity.asc"
        case .releaseDateAsc:
            return "primary_release_date.asc"
        }
    }
}
