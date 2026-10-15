//
//  DataFetcher.swift
//  MyFirstApp
//
//  Created by sespure on 20.03.2026.
//

import Foundation

struct DataFetcher {
    
    let tmdbBaseURL = APIConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = APIConfig.shared?.tmdbAPIKey
    
    
    func fetchTitles(for media: String, by type: String, with title: String? = nil) async throws -> [Title] {
      let fetchTitlesURL = try self.buildURL(media: media, type: type, searchPhrase: title)
       
        guard let fetchTitlesURL = fetchTitlesURL else {
            throw networkError.urlBuildFailed
        }
        
        print(fetchTitlesURL)
        
        let(data, URLResponse) = try await URLSession.shared.data(from: fetchTitlesURL)
        
        guard let response = URLResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw networkError.badURLResponse(underlyingError: NSError(
                domain: "DataFetcher",
                code: (URLResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles =  try decoder.decode(APIObject.self, from: data).results
        Constants.addPosterPath(to: &titles)
        return titles
    }
    
    private func buildURL(media: String, type: String, searchPhrase: String? = nil) throws -> URL? {
        guard let baseURL = tmdbBaseURL else {
            throw networkError.missingConfig
        }
        guard let apiKey = tmdbAPIKey else {
            throw networkError.missingConfig
        }
        
        var path: String
        
        if type == "trending" {
            path = "3/\(type)/\(media)/day"
        } else if type == "top_rated" || type == "upcoming" {
            path = "3/\(media)/\(type)"
        } else if type == "search" {
            path = "3/\(type)/\(media)"
        } else {
            throw networkError.urlBuildFailed
        }
        
        var urlQueryItems = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        if let searchPhrase {
            urlQueryItems.append(URLQueryItem(name: "query", value: searchPhrase))
        }
        
        guard let url =  URL(string: baseURL)?
            .appending(path: path)
            .appending(queryItems: urlQueryItems) else {
            throw networkError.urlBuildFailed
        }
        
        return url
    }
}
