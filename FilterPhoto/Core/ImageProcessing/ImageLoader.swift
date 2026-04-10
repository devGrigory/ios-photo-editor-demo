//
//  ImageLoader.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import UIKit

// MARK: - Image Service Protocol
protocol ImageServiceProtocol {
    func loadImage(from url: URL) async throws -> UIImage
}

// MARK: - Image Loader
final class ImageLoader: ImageServiceProtocol {
    
    // MARK: - Singleton
    static let shared = ImageLoader()
    private init() {}
    
    // MARK: - Image Loading
    func loadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(
                domain: "ImageLoader",
                code: 0,
                userInfo: [NSLocalizedDescriptionKey: "Invalid Data"]
            )
        }
        return image
    }
}
