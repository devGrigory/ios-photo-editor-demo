//
//  PhotosConfigurator.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - PhotosConfigurator
final class PhotosConfigurator {
    
    // MARK: - Configuration
    static func configure() -> PhotosViewController {
        
        let cache = NSCache<NSString, UIImage>()
        
        let imageService = PhotosImageService(cache: cache)
        let prefetchService = PhotosPrefetchService(cache: cache)
        
        let dataSource = PhotosDataSource(
            imageService: imageService,
            prefetchService: prefetchService
        )
        
        let photosView = PhotosView(dataSource: dataSource)
        
        /// VIP Cycle
        let viewController = PhotosViewController(photosView: photosView)
        let worker = PhotosWorker(service: NetworkService())
        let interactor = PhotosInteractor(worker: worker)
        let presenter = PhotosPresenter()
        let router = PhotosRouter()
        
        /// Wiring
        router.viewController = viewController
        presenter.viewController = viewController
        
        interactor.presenter = presenter
        
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
