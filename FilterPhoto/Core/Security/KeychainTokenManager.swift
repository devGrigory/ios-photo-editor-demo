//
//  KeychainTokenManager.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import SwiftUI

// MARK: - Token Storage
protocol TokenStorage {
    var accessToken: String? { get set }
}

// MARK: - Token Manager
final class KeychainTokenManager: TokenStorage {
    var accessToken: String?
}
