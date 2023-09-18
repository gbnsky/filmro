//
//  Language.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

// MARK: - Enum

enum Language: String, CaseIterable {
    
    // MARK: - Cases
    
    case english = "en-US"
    case portuguese = "pt-BR"
    
    // MARK: - Properties
    
    var code: String {
        switch self {
        case .english:
            return "en"
        case .portuguese:
            return "pt"
        }
    }
    
    var region: String {
        switch self {
        case .english:
            return "US"
        case .portuguese:
            return "BR"
        }
    }
    
    var query: String {
        switch self {
        case .english:
            return "en-US"
        case .portuguese:
            return "pt-BR"
        }
    }
}
