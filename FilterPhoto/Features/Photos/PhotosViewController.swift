//
//  PhotosViewController.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - PhotosViewControllerOutput
protocol PhotosBusinessLogic {
    func fetchPhotos(request: PhotosModel.FetchPhotosList.Request) async
    func selectPhoto(request: PhotosModel.SelectedPhoto.Request) async
}

// MARK: - PhotosViewControllerInput
protocol PhotosDisplayLogic: AnyObject {
    func reloadDataWithPhotoList(_ viewModel: PhotosModel.FetchPhotosList.ViewModel)
    func showSelectedPhoto(viewModel: PhotosModel.SelectedPhoto.ViewModel)
}

// MARK: - PhotosViewController
class PhotosViewController: UIViewController {
    
    // MARK: - Properties
    var interactor: PhotosInteractorInput?
    var router: PhotosRouterDelegate?
    
    private let photosView: PhotosView
    
    // MARK: - Init
    init(photosView: PhotosView) {
        self.photosView = photosView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupDelegates()
        loadPhotos()
    }
    
    // MARK: - Setup
    private func setupView() {
        view = photosView
        title = "Photos"
    }
    
    private func setupDelegates() {
        photosView.delegate = self
    }
    
    // MARK: - Data Loading
    private func loadPhotos() {
        guard let interactor else {
            print("❌ interactor is nil")
            return
        }
        
        Task {
            await interactor.fetchPhotos(request: .init())
        }
    }
}

// MARK: - PhotosViewControllerInput
extension PhotosViewController: PhotosDisplayLogic {
    
    func reloadDataWithPhotoList(_ viewModel: PhotosModel.FetchPhotosList.ViewModel) {
        photosView.update(with: viewModel.imageURLs)
    }
    
    func showSelectedPhoto(viewModel: PhotosModel.SelectedPhoto.ViewModel) {
        router?.showSelectedPhoto(image: viewModel.image)
    }
}

// MARK: - PhotosViewDelegate
extension PhotosViewController: PhotosViewDelegate {
    
    func didSelectPhoto(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let request = PhotosModel.SelectedPhoto.Request(url: url)
        Task {
            await interactor?.selectPhoto(request: request)
        }
    }
}
