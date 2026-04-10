//
//  PhotoCell.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - UI Table View Cell
final class PhotoCell: UITableViewCell {
    
    // MARK: - Identifier
    static let id = "PhotoCell"
    
    // MARK: - UI Components
    private let originalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor(white: 0.85, alpha: 1).cgColor,
            UIColor(white: 0.95, alpha: 1).cgColor,
            UIColor(white: 0.85, alpha: 1).cgColor
        ]
        layer.startPoint = CGPoint(x: 0, y: 0.5)
        layer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.locations = [0, 0.5, 1]
        layer.isHidden = true
        return layer
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupShimmer()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Setup Views
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(originalImageView)
        NSLayoutConstraint.activate([
            originalImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            originalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            originalImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            originalImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            originalImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Shimmer Setup
    private func setupShimmer() {
        originalImageView.layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        gradientLayer.frame = originalImageView.bounds
        CATransaction.commit()
    }
    
    // MARK: - Public API (Shimmer Control)
    func startShimmering() {
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
        gradientLayer.frame = originalImageView.bounds
        
        gradientLayer.isHidden = false
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.5
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering() {
        gradientLayer.removeAllAnimations()
        gradientLayer.isHidden = true
    }
    
    // MARK: - Configuration
    func configure(image: UIImage?) {
        if let image = image {
            stopShimmering()
            originalImageView.image = image
        } else {
            originalImageView.image = nil
            startShimmering()
        }
    }
    
    func setLoading(_ isLoading: Bool) {
        if isLoading {
            originalImageView.image = nil
            startShimmering()
        } else {
            stopShimmering()
        }
    }
}
