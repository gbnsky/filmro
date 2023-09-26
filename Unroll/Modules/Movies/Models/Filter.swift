//
//  Filter.swift
//  Unroll
//
//  Created by Gabriel Garcia on 13/09/23.
//

// MARK: - Class

class Filter {
    
    // MARK: - Properties
    
    let includeAdult = "false"
    let includeVideo = "false"
    let sortBy: SortBy
    let genres: [Genre]
    let watchProviders: [WatchProvider]
    var page = String()
    
    // MARK: - Initializers
    
    init(page: String, sortBy: SortBy, genres: [Genre], watchProviders: [WatchProvider]) {
        self.page = page
        self.sortBy = sortBy
        self.genres = genres
        self.watchProviders = watchProviders
    }
    
    // MARK: - Methods
    
    func getFormattedGenres() -> String {
        var ids = String()
        
        for genre in genres {
            let id = String(genre.id)
            ids.append(id)
            
            if genre == genres.last {
                break
            }
            
            ids.append(",")
        }
        
        return ids
    }
    
    func getFormattedWatchProviders() -> String {
        var ids = String()
        
        for watchProvider in watchProviders {
            let id = String(watchProvider.providerId)
            ids.append(id)
            
            if watchProvider == watchProviders.last {
                break
            }
            
            ids.append("|")
        }
        
        return ids
    }
}
