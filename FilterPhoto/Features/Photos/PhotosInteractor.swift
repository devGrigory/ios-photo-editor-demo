//
//  PhotosInteractor.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - PhotosPresentationLogic
protocol PhotosInteractorOutput: AnyObject {
    func presentPhotosLists(_ response: [PhotosModel.FetchPhotosList.Response])
    func presentSelectedPhoto(_ response: PhotosModel.SelectedPhoto.Response)
}

// MARK: - PhotosInteractorInput
typealias PhotosInteractorInput = PhotosBusinessLogic

// MARK: - PhotosInteractor
final class PhotosInteractor {
    
    // MARK: - Properties
    var presenter: PhotosPresenterInput?
    private let worker: PhotosWorkerProtocol
    
    // MARK: - Init
    init(worker: PhotosWorkerProtocol) {
        self.worker = worker
    }
}

// MARK: - PhotosInteractorInput
extension PhotosInteractor: PhotosInteractorInput {
    
    func fetchPhotos(request: PhotosModel.FetchPhotosList.Request) async {
        do {
            let response = try await worker.fetchPhotos()
            presenter?.presentPhotosLists(response)
        } catch {
            print(error)
        }
    }
    
    func selectPhoto(request: PhotosModel.SelectedPhoto.Request) async {
        
        do {
            let image = try await worker.fetchImage(url: request.url)
            
            let response = PhotosModel.SelectedPhoto.Response(image: image)
            presenter?.presentSelectedPhoto(response)
        } catch {
            print("❌ error:", error)
        }
    }
}
