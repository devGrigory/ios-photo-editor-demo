//
//  FilteredPhotoPresenter.swift
//  FilterPhoto
//
//  Created by Grisha on 02.06.23.
//

import Foundation

// MARK: - Typealiases
typealias FilteredPhotoPresenterInput = FilteredPhotoInteractorOutput
typealias FilteredPhotoPresenterOutput = PhotoEditorDisplayLogic

// MARK: - Presenter
final class PhotoEditorPresenter {
    
    // MARK: - Properties
    weak var viewController: FilteredPhotoPresenterOutput?
}

// MARK: - Presentation Logic
extension PhotoEditorPresenter: FilteredPhotoPresenterInput {
    
    func presentFilteredPhoto(_ response: FilteredPhotoModel.ShowFilteredPhoto.Response) {
        let viewModel = FilteredPhotoModel.ShowFilteredPhoto.ViewModel(image: response.image)
        
        viewController?.displayFilteredPhoto(viewModel)
    }
    
    func presentAppliedFilter(_ response: FilteredPhotoModel.ApplyFilter.Response) {
        let viewModel = FilteredPhotoModel.ApplyFilter.ViewModel(
            image: response.image
        )
        
        viewController?.displayAppliedFilter(viewModel)
    }
}
