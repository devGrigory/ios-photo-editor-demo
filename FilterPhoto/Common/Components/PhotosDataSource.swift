//
//  PhotosDataSource.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - Photos Data Source
final class PhotosDataSource: NSObject, UITableViewDataSourcePrefetching {
    
    // MARK: - Properties
    var items: [String] = []
    weak var delegate: PhotosViewDelegate?
    
    let imageService: PhotosImageService
    let prefetchService: PhotosPrefetchService
    
    // MARK: - Init
    init(imageService: PhotosImageService,
         prefetchService: PhotosPrefetchService) {
        self.imageService = imageService
        self.prefetchService = prefetchService
    }
}

// MARK: - UITableViewDataSource
extension PhotosDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PhotoCell.id,
            for: indexPath
        ) as? PhotoCell else {
            return UITableViewCell()
        }
        
        cell.setLoading(true)
        
        let url = items[indexPath.row]
        
        imageService.loadImage(
            urlString: url,
            indexPath: indexPath,
            cell: cell,
            tableView: tableView
        )
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PhotosDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectPhoto(urlString: items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach {
            prefetchService.prefetch(urlString: items[$0.row])
        }
    }
}
