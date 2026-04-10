//
//  PhotoEditorViewController.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - Business Logic (Interactor)
protocol PhotoEditorBusinessLogic {
    func showPhoto(request: PhotoEditorModel.ShowPhoto.Request)
    func applyFilter(request: PhotoEditorModel.ApplyFilter.Request)
}

// MARK: - Display Logic (ViewController)
protocol PhotoEditorDisplayLogic: AnyObject {
    func displayPhoto(_ viewModel: PhotoEditorModel.ShowPhoto.ViewModel)
    func displayAppliedFilter(_ viewModel: PhotoEditorModel.ApplyFilter.ViewModel)
}

class PhotoEditorViewController: UIViewController {
    
    // MARK: - Properties
    var interactor: PhotoEditorInteractorInput?
    var router: PhotoEditorRouterDelegate?
    
    // MARK: - UI
    private let photoEditorView: PhotoEditorView
    
    // MARK: - Data
    var image: UIImage?
    
    // MARK: - Init
    init(photoEditorView: PhotoEditorView, image: UIImage?) {
        self.photoEditorView = photoEditorView
        self.image = image
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
        showFilteredPhoto()
    }
    
    // MARK: - Setup
    private func setupView() {
        view = photoEditorView
        title = "Edit Photo"
    }
    
    private func setupDelegates() {
        photoEditorView.delegate = self
    }
    
    // MARK: - Requests
    private func showFilteredPhoto() {
        interactor?.showPhoto(request: PhotoEditorModel.ShowPhoto.Request(image: image))
    }
}

// MARK: - Filtered Photo Display Logic
extension PhotoEditorViewController: PhotoEditorDisplayLogic {
    
    func displayPhoto(_ viewModel: PhotoEditorModel.ShowPhoto.ViewModel) {
        photoEditorView.setImage(viewModel.image)
    }
    
    func displayAppliedFilter(_ viewModel: PhotoEditorModel.ApplyFilter.ViewModel) {
        photoEditorView.setImage(viewModel.image)
    }
}

// MARK: - View Delegate
extension PhotoEditorViewController: PhotoEditorViewDelegate {
    func didSelectFilter(_ filter: Filter) {
        interactor?.applyFilter(
            request: PhotoEditorModel.ApplyFilter.Request(
                image: image,
                filter: filter
            )
        )
    }
}
