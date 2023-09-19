//
//  WatchProvidersHelper.swift
//  Unroll
//
//  Created by Gabriel Garcia on 19/09/23.
//

import UIKit

// MARK: - Class

class WatchProvidersHelper {
    
    // MARK: - Properties
    
    private let region: Location = MovieApi.shared.getWatchRegion()
    
    private let watchProviders: WatchProviders
    
    // MARK: - Initializers
    
    init(watchProviders: WatchProviders) {
        self.watchProviders = watchProviders
    }
    
    // MARK: - Exposed Methods
    
    func getFlatrateWatchProvidersNames() -> String {
        var watchProvidersNames = String()
        
        if let flatrateWatchProviders = getFlatrateWatchProviders() {
            
            for flatrateWatchProvider in flatrateWatchProviders {
                watchProvidersNames.append(flatrateWatchProvider.providerName ?? String())
                
                if flatrateWatchProvider == flatrateWatchProviders.last {
                    break
                }
                
                watchProvidersNames.append(" - ")
            }
        }
        
        return watchProvidersNames
    }
    
    // MARK: - Private Methods

    private func getFlatrateWatchProviders() -> [WatchProvider]? {
        let result = getWatchProviderResult()
        return result?.flatrate
    }
    
    private func getWatchProviderResult() -> WatchProviderResult? {
        
        switch region {
            
        case .usa:
            return watchProviders.results?.us
            
        case .brazil:
            return watchProviders.results?.br
            
        }
    }
}
