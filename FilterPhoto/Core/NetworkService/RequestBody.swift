//
//  RequestBody.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import Foundation

// MARK: - Optional Encodable
protocol OptionalEncodable: Encodable {
    var isEmptyBody: Bool { get }
}

// MARK: - Default Implementation
extension OptionalEncodable {
    var isEmptyBody: Bool { false }
}

// MARK: - Empty Request Body
final class EmptyRequestBody: OptionalEncodable {
    var isEmptyBody: Bool { true }
}
