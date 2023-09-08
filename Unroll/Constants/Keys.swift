//
//  Keys.swift
//  Unroll
//
//  Created by Gabriel Garcia on 08/09/23.
//

import UIKit

// MARK: - Protocols

public protocol APIKey {
    var value: String { get }
}

// MARK: - Key Handler

private class KeyHandler {
    
    let dictionary: NSDictionary
    let resourceName: String = "Keys"
    
    init() {
        
        guard let filePath = Bundle.main.path(forResource: resourceName, ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: filePath) else {
            fatalError("Unable to find \(resourceName) plist file.")
        }
        
        self.dictionary = plist
    }
}

// MARK: - API Keys

// The Movie Database
public var MovieApiKey: APIKey {
    return MovieAPIKey()
}

private class MovieAPIKey: KeyHandler, APIKey {
    var value: String {
        dictionary.object(forKey: "Movie API Key") as? String ?? String()
    }
}
