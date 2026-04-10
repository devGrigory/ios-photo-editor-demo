//
//  PhotosPresenter.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - PhotosPresenterInput
typealias PhotosPresenterInput = PhotosInteractorOutput

// MARK: - PhotosPresenterOutput
typealias PhotosPresenterOutput = PhotosDisplayLogic

// MARK: - PhotosPresenter
final class PhotosPresenter {
    // MARK: - Properties
    weak var viewController: PhotosPresenterOutput?
}

// MARK: - PhotosPresenterInput
extension PhotosPresenter: PhotosPresenterInput {
    
    func presentPhotosLists(_ response: [PhotosModel.FetchPhotosList.Response]) {
        let imageURLs = response.map { $0.downloadURL }
        let viewModel = PhotosModel.FetchPhotosList.ViewModel(
            imageURLs: imageURLs
        )
        Task { @MainActor in
            viewController?.reloadDataWithPhotoList(viewModel)
        }
    }
    
    func presentSelectedPhoto(_ response: PhotosModel.SelectedPhoto.Response) {
        let viewModel = PhotosModel.SelectedPhoto.ViewModel(image: response.image)
        Task { @MainActor in
            viewController?.showSelectedPhoto(viewModel: viewModel)
        }
    }
}
