//
//  WatchProviders.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

// MARK: - Response

struct WatchProvidersResponse: Codable {
    let id: Int?
    let results: WatchProviderResults?
}

struct WatchProviderResults: Codable {
    let us: WatchProviderResult?
    let br: WatchProviderResult?

    enum CodingKeys: String, CodingKey {
        case us = "US"
        case br = "BR"
    }
}

struct WatchProviderResult: Codable {
    let link: String?
    let rent: [WatchProviderResponse]?
    let buy: [WatchProviderResponse]?
    let flatrate: [WatchProviderResponse]?
}

struct WatchProviderResponse: Codable, Equatable {
    let logoPath: String?
    let providerId: Int?
    let providerName: String?
    let displayPriority: Int?
}

// MARK: - Type

struct WatchProviders: Codable {
    let results: [WatchProvider]
}

struct WatchProvider: Codable, Equatable {
    let displayPriorities: DisplayPriority
    let displayPriority: Int
    let providerName: String
    let providerId: Int
}

struct DisplayPriority: Codable, Equatable {
    let us: Int?
    let br: Int?

    enum CodingKeys: String, CodingKey {
        case us = "US"
        case br = "BR"
    }
}
