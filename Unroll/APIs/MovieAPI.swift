//
//  MovieAPI.swift
//  Unroll
//
//  Created by Gabriel Garcia on 07/09/23.
//

import UIKit

final class MovieApi {
    
    // MARK: - Singleton
    
    static let shared = MovieApi()
    
    // MARK: - Exposed Methods
    
    var watchRegion: Location = .usa
    var language: Language = .english
    
    // MARK: - Private Properties
    
    private let baseUrl = URL(string: "https://api.themoviedb.org/3")!
    private let headers = [
        "accept": "application/json",
        "Authorization": MovieApiKey.value
    ]
    
    // MARK: - Methods
    
    /// Gets all the enable movie genres on API
    /// - Parameter completion: returns an array of genre
    func getMovieGenreList(completion: @escaping ([Genre]?) -> ()) {
        
        var url = baseUrl.appending(component: "genre/movie/list")
        let queryItems = [
            URLQueryItem(name: "language", value: language.query),
        ]
        url.append(queryItems: queryItems)
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let movieGenres = try? decoder.decode(Genres.self, from: data) else {
                return
            }
            
            completion(movieGenres.genres)
        })
        
        dataTask.resume()
    }
    
    /// Gets a list of movies using filters selected by the user
    /// - Parameters:
    ///   - filters: options selected by user to get a list of movies with a specific description
    ///   - completion: returns a movies object that has an array of movie and their current page
    func getMovieDiscoverList(filters: Filters, completion: @escaping (Movies?) -> ()) {
        
        var url = baseUrl.appending(component: "discover/movie")
        let queryItems = [
            URLQueryItem(name: "include_adult", value: filters.includeAdult),
            URLQueryItem(name: "include_video", value: filters.includeVideo),
            URLQueryItem(name: "language", value: language.query),
            URLQueryItem(name: "watch_region", value: watchRegion.query),
            URLQueryItem(name: "page", value: filters.page),
            URLQueryItem(name: "sort_by", value: filters.sortBy.query),
            URLQueryItem(name: "with_genres", value: filters.getFormattedGenres()),
        ]
        url.append(queryItems: queryItems)
        
        print("url: \(url)")
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard let data = data else {
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase

            guard let movieDiscoveries = try? decoder.decode(Movies.self, from: data) else {
                return
            }

            completion(movieDiscoveries)
        })

        dataTask.resume()
    }
    
    /// Gets a various parameter number with movie information
    /// - Parameters:
    ///   - movie: the selected movie to get
    ///   - completion: returns a movie object with additional info
    func getMovieDetails(from movie: Movie, completion: @escaping (Movie?) -> ()) {
        
        guard let movieId = movie.id else {
            return
        }
        
        var url = baseUrl.appending(component: "movie/\(movieId)")
        let queryItems = [
            URLQueryItem(name: "language", value: language.query),
        ]
        url.append(queryItems: queryItems)
        
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard let data = data else {
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let movieDetails = try? decoder.decode(Movie.self, from: data) else {
                return
            }
            
            completion(movieDetails)
        })
        
        dataTask.resume()
        
    }
    
    // MARK: - Helper Methods
    
    func isOriginalLanguage(_ resultLanguage: String) -> Bool {
        let separator = String("-")
        let globalLanguageArray = self.language.query.components(separatedBy: separator)
        let globalLanguage = globalLanguageArray.first
        
        return globalLanguage == resultLanguage
    }
}
