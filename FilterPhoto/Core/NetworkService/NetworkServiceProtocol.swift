//
//  NetworkServiceProtocol.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import Foundation

// MARK: - Auth Service
protocol AuthServiceProtocol {
    func signup(user: SignupRequest) async throws -> SignupResponse
}

// MARK: - Photos Service
protocol PhotosServiceProtocol {
    func fetchAllPhotos() async throws -> [PhotosModel.FetchPhotosList.Response]
    func fetchPhotosByCategory(category: PhotosCategory) async throws -> [PhotosModel.FetchPhotosList.Response]
}

// MARK: - Update Service
protocol UpdateServiceProtocol {
    func updateAllPhotosList() async throws -> [UpdatePhotosListResponse]
    func deletePhotoFromList(forNumber: Int) async throws -> [DeletePhotosListResponse]
}
