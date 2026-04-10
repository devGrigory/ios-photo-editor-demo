//
//  PhotoEditorPresenter.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import Foundation

// MARK: - Typealiases
typealias PhotoEditorPresenterInput = PhotoEditorInteractorOutput
typealias PhotoEditorPresenterOutput = PhotoEditorDisplayLogic

// MARK: - Presenter
final class PhotoEditorPresenter {
    
    // MARK: - Properties
    weak var viewController: PhotoEditorPresenterOutput?
}

// MARK: - Presentation Logic
extension PhotoEditorPresenter: PhotoEditorPresenterInput {
    
    func presentPhoto(_ response: PhotoEditorModel.ShowPhoto.Response) {
        let viewModel = PhotoEditorModel.ShowPhoto.ViewModel(image: response.image)
        
        viewController?.displayPhoto(viewModel)
    }
    
    func presentAppliedFilter(_ response: PhotoEditorModel.ApplyFilter.Response) {
        let viewModel = PhotoEditorModel.ApplyFilter.ViewModel(
            image: response.image
        )
        
        viewController?.displayAppliedFilter(viewModel)
    }
}
