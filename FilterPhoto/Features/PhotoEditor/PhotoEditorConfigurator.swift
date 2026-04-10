//
//  PhotoEditorConfigurator.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - Configurator
final class PhotoEditorConfigurator {
    
    // MARK: - Configuration
    static func configure(
        _ viewController: PhotoEditorViewController
    ) -> PhotoEditorViewController {
        
        let interactor = PhotoEditorInteractor()
        let presenter = PhotoEditorPresenter()
        let router = PhotoEditorRouter()
        
        // MARK: - Connections
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        router.viewController = viewController
        
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}
