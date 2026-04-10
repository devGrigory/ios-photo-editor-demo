//
//  PhotosImageService.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import UIKit

// MARK: - Image Service
final class PhotosImageService {
    
    // MARK: - Properties
    private let cache: NSCache<NSString, UIImage>
    private var runningTasks: [IndexPath: Task<Void, Never>] = [:]
    
    // MARK: - Init
    init(cache: NSCache<NSString, UIImage>) {
        self.cache = cache
    }
    
    // MARK: - Cache
    func cachedImage(for url: String) -> UIImage? {
        cache.object(forKey: url as NSString)
    }
    
    // MARK: - Task Management
    func cancelTask(for indexPath: IndexPath) {
        runningTasks[indexPath]?.cancel()
    }
    
    // MARK: - Image Loading
    func loadImage(
        urlString: String,
        indexPath: IndexPath,
        cell: PhotoCell,
        tableView: UITableView
    ) {
        if let cached = cachedImage(for: urlString) {
            cell.configure(image: cached)
            return
        }
        
        cell.configure(image: nil)
        cancelTask(for: indexPath)
        
        let task = Task {
            do {
                guard let url = URL(string: urlString) else { return }
                
                let fetchedImage = try await ImageLoader.shared.loadImage(from: url)
                try Task.checkCancellation()
                
                let size = CGSize(width: 300, height: 200)
                let finalImage = await fetchedImage.byPreparingThumbnail(ofSize: size) ?? fetchedImage
                
                self.cache.setObject(finalImage, forKey: urlString as NSString)
                
                await MainActor.run {
                    if tableView.indexPath(for: cell) == indexPath {
                        cell.configure(image: finalImage)
                    }
                }
            } catch {
                await MainActor.run {
                    if tableView.indexPath(for: cell) == indexPath {
                        cell.setLoading(false)
                    }
                }
            }
        }
        runningTasks[indexPath] = task
    }
}
