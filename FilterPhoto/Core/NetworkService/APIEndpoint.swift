//
//  APIEndpoint.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import Foundation

// MARK: - API Endpoint
enum APIEndpoint {
    
    // MARK: - Cases
    case signup
    case update
    case fetchPhotos
    case fetchPhotosByCategory(PhotosCategory)
    case delete(Int)
    
    // MARK: - URL Builder
    private func baseURL() throws -> URL {
        guard let url = URL(string: "https://picsum.photos") else {
            throw AppError.invalidBaseURL
        }
        return url
    }
    
    /// Builds full URL (path + query)
    private func buildURL() throws -> URL {
        var components = URLComponents(url: try baseURL(), resolvingAgainstBaseURL: false)
        
        switch self {
            
            // MARK: - Photos
        case .fetchPhotos:
            components?.path = "/v2/list"
            components?.queryItems = [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "limit", value: "10")
            ]
            
        case .fetchPhotosByCategory:
            components?.path = "/v2/list"
            
            // MARK: - Default
        default:
            components?.path = path
        }
        
        guard let url = components?.url else {
            throw AppError.invalidBaseURL
        }
        return url
    }
}

// MARK: - Request Config
extension APIEndpoint {
    // MARK: - Path
    var path: String {
        switch self {
        case .signup:
            return "/...."
        case .update:
            return "/...."
        case .fetchPhotos:
            return "/v2/list"
        case .fetchPhotosByCategory:
            return "/v2/list"
        case .delete(let photoID):
            return "/....\(photoID)"
        }
    }
    
    // MARK: - HTTP Method
    var method: String {
        switch self {
        case .signup:
            return "POST"
        case .fetchPhotos:
            return "GET"
        case .fetchPhotosByCategory:
            return "GET"
        case .update:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }
    
    // MARK: - URL
    var url: URL {
        get throws {
            try buildURL()
        }
    }
    
    // MARK: - Headers
    var headers: [String: String] {
        var headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        switch self {
        case .update, .delete:
            let tokenManager: TokenStorage = KeychainTokenManager()
            let token = tokenManager.accessToken
            if let accessToken = token,
               !accessToken.isEmpty {
                headers["Authorization"] = "Bearer \(accessToken)"
            }
        default:
            break
        }
        return headers
    }
}

// MARK: - Photo Category
enum PhotosCategory: String {
    
    // MARK: - Cases
    case nature
    case animals
    case travel
    case architecture
    case people
    case technology
}
