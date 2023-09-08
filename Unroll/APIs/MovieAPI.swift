//
//  MovieAPI.swift
//  Unroll
//
//  Created by Gabriel Garcia on 07/09/23.
//

import UIKit

final class MovieApi {
    
    // MARK: - Public Properties
    
    static let shared = MovieApi()
    
    // MARK: - Private Properties
    
    private let baseUrl = URL(string: "https://api.themoviedb.org/3")!
    private let headers = [
        "accept": "application/json",
        "Authorization": MovieApiKey.value
    ]
    
    // MARK: - Methods
    
    func getMovieGenres(completion: @escaping ([Genre]?) -> ()) {
        
        let url = baseUrl.appending(component: "genre/movie/list")
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
}
