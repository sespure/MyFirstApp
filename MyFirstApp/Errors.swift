//
//  Errors.swift
//  MyFirstApp
//
//  Created by sespure on 19.03.2026.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLoadingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "API configuration file not found"
        case .dataLoadingFailed(underlyingError: let error):
            return "Failed to load data: \(error.localizedDescription)"
        case .decodingFailed (underlyingError: let error):
            return "Failed to decode API configuration: \(error.localizedDescription)."
        }
    }
}

enum networkError: Error, LocalizedError {
    case badURLResponse (underlyingError: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingError: let error):
            return "Failed to parse URL response: \(error.localizedDescription)."
        case .missingConfig:
            return "API configuration is missing."
        case .urlBuildFailed:
            return "Failed to build URL."
        }
    }
}
