//
//  Filters.swift
//  Unroll
//
//  Created by Gabriel Garcia on 13/09/23.
//

// MARK: - Class

class Filters {
    
    // MARK: - Properties
    
    let includeAdult = "false"
    let includeVideo = "false"
    let language = "en-US"
    let sortBy: SortBy
    let genres: [Genre]
    var page = String()
    
    // MARK: - Initializers
    
    init(page: String, sortBy: SortBy, genres: [Genre]) {
        self.page = page
        self.sortBy = sortBy
        self.genres = genres
    }
    
    // MARK: - Methods
    
    func getFormattedGenres() -> String {
        var genreIdsString = String()
        
        for genre in genres {
            let genreIdString = String(genre.id)
            genreIdsString.append(genreIdString)
            
            if genre == genres.last {
                break
            }
            
            genreIdsString.append(",")
        }
        
        return genreIdsString
    }
}
