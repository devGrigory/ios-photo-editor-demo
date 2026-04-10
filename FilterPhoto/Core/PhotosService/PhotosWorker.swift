//
//  PhotosWorker.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import UIKit

// MARK: - Photos Worker Protocol
protocol PhotosWorkerProtocol {
    func fetchPhotos() async throws -> [PhotosModel.FetchPhotosList.Response]
    func fetchImage(url: URL) async throws -> UIImage
}

// MARK: - Photos Worker
final class PhotosWorker: PhotosWorkerProtocol {
    
    // MARK: - Properties
    private let service: PhotosServiceProtocol
    
    // MARK: - Init
    init(service: PhotosServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Photos Fetching
    func fetchPhotos() async throws -> [PhotosModel.FetchPhotosList.Response] {
        try await service.fetchAllPhotos()
    }
    
    // MARK: - Image Fetching
    func fetchImage(url: URL) async throws -> UIImage {
        try await ImageLoader.shared.loadImage(from: url)
    }
}
