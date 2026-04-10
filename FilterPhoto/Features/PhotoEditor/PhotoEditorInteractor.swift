//
//  PhotoEditorInteractor.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - Presentation Logic
protocol PhotoEditorInteractorOutput {
    func presentPhoto(_ response: PhotoEditorModel.ShowPhoto.Response)
    func presentAppliedFilter(_ response: PhotoEditorModel.ApplyFilter.Response)
}

// MARK: - Business Logic Typealias
typealias PhotoEditorInteractorInput = PhotoEditorBusinessLogic

// MARK: - Interactor
final class PhotoEditorInteractor {
    
    // MARK: - Properties
    var presenter: PhotoEditorPresenterInput?
    private let filterProcessor: FilterProcessor
    
    init(filterProcessor: FilterProcessor = FilterProcessor()) {
        self.filterProcessor = filterProcessor
    }
}

extension PhotoEditorInteractor: PhotoEditorInteractorInput {
    
    // MARK: - Business Logic
    func showPhoto(request: PhotoEditorModel.ShowPhoto.Request) {
        
        let response = PhotoEditorModel.ShowPhoto.Response(
            image: request.image
        )
        
        presenter?.presentPhoto(response)
    }
    
    func applyFilter(request: PhotoEditorModel.ApplyFilter.Request) {
        guard let image = request.image else {
            presenter?.presentAppliedFilter(.init(image: nil))
            return
        }
        
        let processedImage = filterProcessor.apply(
            filter: request.filter,
            to: image
        )
        
        let response = PhotoEditorModel.ApplyFilter.Response(
            image: processedImage
        )
        
        presenter?.presentAppliedFilter(response)
    }
}
