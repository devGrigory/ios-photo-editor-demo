//
//  PhotosRouter.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - PhotosRoutingLogic
protocol PhotosRouterDelegate {
    func showSelectedPhoto(image: UIImage)
}

// MARK: - PhotosRouter
final class PhotosRouter {
    // MARK: - Properties
    weak var viewController: PhotosViewController?
}
    
// MARK: - PhotosRouterDelegate
extension PhotosRouter: PhotosRouterDelegate {
    
    func showSelectedPhoto(image: UIImage) {
        let filteredPhotoVC = PhotoEditorConfigurator.configure(
            PhotoEditorViewController(photoEditorView: PhotoEditorView(), image: image)
        )
        
        viewController?.navigationController?.pushViewController(filteredPhotoVC, animated: true)
    }
}
