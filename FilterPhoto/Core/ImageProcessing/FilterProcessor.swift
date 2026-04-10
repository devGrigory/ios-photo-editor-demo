//
//  FilterProcessor.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import UIKit

// MARK: - Filter Processor
final class FilterProcessor {
    
    // MARK: - Properties
    private let context = CIContext()
    
    // MARK: - Applying Filters
    func apply(filter: Filter, to image: UIImage) -> UIImage? {
        guard let ciImage = CIImage(image: image),
              let output = filter.type.apply(to: ciImage),
              let cgImage = context.createCGImage(output, from: output.extent)
        else {
            return image
        }
        
        return UIImage(cgImage: cgImage)
    }
}
