//
//  PhotoEditorRouter.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - Routing Logic
protocol PhotoEditorRouterDelegate {
    //func routeToPhotos()
}

// MARK: - Router
final class PhotoEditorRouter {
    
    // MARK: - Properties
    weak var viewController: UIViewController?
}
    
// MARK: - Navigation
extension PhotoEditorRouter: PhotoEditorRouterDelegate {
    //func routeToPhotos() {}
}
