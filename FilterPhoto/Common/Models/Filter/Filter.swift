//
//  FilterType.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import Foundation

import CoreImage
import CoreImage.CIFilterBuiltins

struct Filter {
    let id: String
    let title: String
    let type: FilterType
}

// MARK: - Filter Type
enum FilterType {
    case colorMatrix
    case colorControls
    case hueAdjust
    case vibrance
    case sepia
    
    case exposure
    case brightness
    case contrast
    case gamma
    
    case gaussianBlur
    case motionBlur
    case zoomBlur
    
    case twirl
    case pinch
    case bump
    
    case pixellate
    case crystallize
    case comic
    
    case noir
    case vivid
    case autoEnhance
    case original
}
