//
//  PhotosPrefetchService.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import UIKit

// MARK: - Photos Prefetch Service
final class PhotosPrefetchService {
    
    // MARK: - Properties
    private let cache: NSCache<NSString, UIImage>
    
    // MARK: - Init
    init(cache: NSCache<NSString, UIImage>) {
        self.cache = cache
    }
    
    // MARK: - Prefetch
    func prefetch(urlString: String) {
        if cache.object(forKey: urlString as NSString) != nil { return }
        
        Task.detached(priority: .background) {
            guard let url = URL(string: urlString) else { return }
            
            let image = try await ImageLoader.shared.loadImage(from: url)
            let size = CGSize(width: 300, height: 200)
            
            if let prepared = await image.byPreparingThumbnail(ofSize: size) {
                await MainActor.run {
                    self.cache.setObject(prepared, forKey: urlString as NSString)
                }
            }
        }
    }
}
