//
//  NetworkService.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import Foundation

// MARK: - Protocols
protocol NetworkServiceProtocol {
    func request<T: OptionalEncodable, U: Decodable>(endpoint: APIEndpoint, body: T) async throws -> U
    var emptyBody: EmptyRequestBody { get set }
}

// MARK: - Network Service
final class NetworkService: NetworkServiceProtocol, AuthServiceProtocol, PhotosServiceProtocol, UpdateServiceProtocol {
    
    // MARK: - Properties
    var appError: AppError?
    var emptyBody = EmptyRequestBody()
    
    // MARK: - Auth Service
    func signup(user: SignupRequest) async throws -> SignupResponse {
        try await request(endpoint: .signup, body: user)
    }
    
    // MARK: - Photos Service
    func fetchAllPhotos() async throws -> [PhotosModel.FetchPhotosList.Response] {
        try await request(endpoint: .fetchPhotos, body: emptyBody)
    }
    
    func fetchPhotosByCategory(category: PhotosCategory) async throws -> [PhotosModel.FetchPhotosList.Response] {
        try await request(endpoint: .fetchPhotosByCategory(category), body: emptyBody)
    }
    
    // MARK: - Update Service
    func updateAllPhotosList() async throws -> [UpdatePhotosListResponse] {
        try await request(endpoint: .update, body: emptyBody)
    }
    
    func deletePhotoFromList(forNumber: Int) async throws -> [DeletePhotosListResponse] {
        try await request(endpoint: .delete(forNumber), body: emptyBody)
    }
    
    // MARK: - Request Builder
    func request<T, U>(
        endpoint: APIEndpoint,
        body: T
    ) async throws -> U where T: OptionalEncodable, U: Decodable {
        
        do {
            let request = try buildRequest(endpoint: endpoint, body: body)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            return try handleResponse(data: data, response: response)
            
        } catch let error as AppError {
            throw error
        } catch {
            throw AppError.network(error)
        }
    }
}

// MARK: - Private Helpers
private extension NetworkService {
    
    // MARK: - Build Request
    func buildRequest<T: OptionalEncodable>(
        endpoint: APIEndpoint,
        body: T
    ) throws -> URLRequest {
        
        var request = URLRequest(url: try endpoint.url)
        request.httpMethod = endpoint.method
        
        endpoint.headers.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if !body.isEmptyBody {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        return request
    }
    
    // MARK: - Handle Response
    func handleResponse<U: Decodable>(
        data: Data,
        response: URLResponse
    ) throws -> U {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.invalidResponse
        }
        
        switch httpResponse.statusCode {
            
            // MARK: - Success
        case 200...299:
            return try decode(data: data)
            
            // MARK: - Redirection
        case 300...399:
            throw AppError.redirection
            
            // MARK: - Client Error
        case 400...499:
            throw parseServerError(data: data) ?? AppError.clientError(status: httpResponse.statusCode)
            
            // MARK: - Server Error
        case 500...599:
            throw parseServerError(data: data) ?? AppError.serverError(status: httpResponse.statusCode)
            
            // MARK: - Unknown
        default:
            throw AppError.unknownStatus(httpResponse.statusCode)
        }
    }
    
    // MARK: - Decode
    func decode<U: Decodable>(data: Data) throws -> U {
        do {
            if let responseString = String(data: data, encoding: .utf8) {
                print("📦 Raw response:\n\(responseString)")
            }
            
            return try JSONDecoder().decode(U.self, from: data)
        } catch {
            throw AppError.decodingFailed
        }
    }
    
    // MARK: - Parse Server Error
    func parseServerError(data: Data) -> AppError? {
        if let serverError = try? JSONDecoder().decode(ServerErrorResponse.self, from: data) {
            return AppError.customServer(message: serverError.error)
        }
        return nil
    }
}
