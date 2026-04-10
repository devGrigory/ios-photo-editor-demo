//
//  PhotoEditorView.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - Delegate
protocol PhotoEditorViewDelegate: AnyObject {
    func didSelectFilter(_ filter: Filter)
}

// MARK: - View
final class PhotoEditorView: UIView {
    
    // MARK: - UI
    private let editorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let buttonsFlowView: FilterButtonsFlowView = {
        let view = FilterButtonsFlowView()
        view.backgroundColor = .clear
        view.spacing = 8
        view.minHorizontalPadding = 16
        view.verticalPadding = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties
    weak var delegate: PhotoEditorViewDelegate?
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupUI()
        configureImageView()
        configureFilterSelectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .white
    }
    
    func configureImageView() {
        addSubview(editorImageView)
        NSLayoutConstraint.activate([
            editorImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 4),
            editorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            editorImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            editorImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureFilterSelectionView() {
        buttonsFlowView.delegate = self
        buttonsFlowView.configure(with: FilterProvider.all)
        addSubview(buttonsFlowView)
        NSLayoutConstraint.activate([
            buttonsFlowView.topAnchor.constraint(equalTo: editorImageView.bottomAnchor, constant: 12),
            buttonsFlowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            buttonsFlowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            buttonsFlowView.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - Public API
extension PhotoEditorView {
    func setImage(_ image: UIImage?) {
        editorImageView.image = image
    }
}

// MARK: - JustifiedFlowLayoutViewDelegate
extension PhotoEditorView: FilterButtonsFlowViewDelegate {
    
    func filterView(_ view: FilterButtonsFlowView, didSelect filter: Filter) {
        
        delegate?.didSelectFilter(filter)
    }
}
