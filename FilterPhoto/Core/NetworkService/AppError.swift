//
//  ErrorHandling.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import Foundation

// MARK: - App Error
enum AppError: LocalizedError, Identifiable {
    case passwordsDoNotMatch
    case invalidBaseURL
    case decodingFailed
    case redirection
    case clientError(status: Int)
    case serverError(status: Int)
    case customServer(message: String)
    case unknownStatus(Int)
    case network(Error)
    case invalidResponse
    
    // MARK: - Identifiable
    var id: String {
        errorDescription ?? UUID().uuidString
    }
    
    // MARK: - Localized Error
    var errorDescription: String? {
        switch self {
        case .passwordsDoNotMatch:
            return "Passwords don't match."
        case .invalidBaseURL:
            return "Invalid base URL."
        case .decodingFailed:
            return "Failed to decode the server response."
        case .redirection:
            return "Request was redirected."
        case .clientError(let status):
            return "Client error occurred. Status code: \(status)"
        case .serverError(let status):
            return "Server error occurred. Status code: \(status)"
        case .customServer(let message):
            return message
        case .unknownStatus(let status):
            return "Unexpected status code: \(status)"
        case .network(let error):
            return error.localizedDescription
        case .invalidResponse:
            return "The response was not a valid HTTP response."
        }
    }
}

// MARK: - Server Error Response
struct ServerErrorResponse: Decodable {
    let error: String
}

// MARK: - ViewModel Error Handling
@MainActor
protocol ErrorHandling: AnyObject {
    var appError: AppError? { get set }
}

// MARK: - Default Implementation
extension ErrorHandling {
    func handleError(_ error: Error) async {
        let appError = (error as? AppError) ?? .network(error)
        await MainActor.run {
            self.appError = appError
        }
    }
}
