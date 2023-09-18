//
//  Location.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

// MARK: - Enum

enum Location: String, CaseIterable {
    
    // MARK: - Cases
    
    case usa
    case brazil
    
    // MARK: - Properties
    
    var title: String {
        switch self {
        case .usa:
            return "United States of America"
        case .brazil:
            return "Brazil"
        }
    }
    
    var query: String {
        switch self {
        case .usa:
            return "US"
        case .brazil:
            return "BR"
        }
    }
}
