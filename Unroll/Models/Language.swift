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
    
    case english
    case portuguese
    
    // MARK: - Properties
    
    var title: String {
        switch self {
        case .english:
            return "English"
        case .portuguese:
            return "Portuguese"
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
