//
//  WatchProviders.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

struct WatchProviders: Codable {
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
    let rent: [WatchProvider]?
    let buy: [WatchProvider]?
    let flatrate: [WatchProvider]?
}

struct WatchProvider: Codable, Equatable {
    let logoPath: String?
    let providerId: Int?
    let providerName: String?
    let displayPriority: Int?
}
