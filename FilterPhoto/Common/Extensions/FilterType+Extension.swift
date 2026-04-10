//
//  FilterType+Extension.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

import CoreImage

// MARK: - Filter Strategy
extension FilterType {
    
    func apply(to ciImage: CIImage) -> CIImage? {
        
        switch self {
            
            // MARK: - 🎨 Color
        case .colorMatrix:
            let f = CIFilter.colorMatrix()
            f.inputImage = ciImage
            return f.outputImage
            
        case .colorControls:
            let f = CIFilter.colorControls()
            f.inputImage = ciImage
            f.saturation = 1.5
            f.brightness = 0.1
            f.contrast = 1.2
            return f.outputImage
            
        case .hueAdjust:
            let f = CIFilter.hueAdjust()
            f.inputImage = ciImage
            f.angle = 0.8
            return f.outputImage
            
        case .vibrance:
            let f = CIFilter.vibrance()
            f.inputImage = ciImage
            f.amount = 1.0
            return f.outputImage
            
        case .sepia:
            let f = CIFilter.sepiaTone()
            f.inputImage = ciImage
            f.intensity = 0.8
            return f.outputImage
            
            // MARK: - ⚙️ Adjustments
        case .exposure:
            let f = CIFilter.exposureAdjust()
            f.inputImage = ciImage
            f.ev = 1.0
            return f.outputImage
            
        case .brightness:
            let f = CIFilter.colorControls()
            f.inputImage = ciImage
            f.brightness = 0.2
            return f.outputImage
            
        case .contrast:
            let f = CIFilter.colorControls()
            f.inputImage = ciImage
            f.contrast = 1.5
            return f.outputImage
            
        case .gamma:
            let f = CIFilter.gammaAdjust()
            f.inputImage = ciImage
            f.power = 0.75
            return f.outputImage
            
            // MARK: - 🌫 Blur
        case .gaussianBlur:
            let f = CIFilter.gaussianBlur()
            f.inputImage = ciImage
            f.radius = 5
            return f.outputImage
            
        case .motionBlur:
            let f = CIFilter.motionBlur()
            f.inputImage = ciImage
            f.radius = 10
            return f.outputImage
            
        case .zoomBlur:
            let f = CIFilter.zoomBlur()
            f.inputImage = ciImage
            f.amount = 20
            return f.outputImage
            
            // MARK: - 🌀 Distortion
        case .twirl:
            let f = CIFilter.twirlDistortion()
            f.inputImage = ciImage
            f.radius = 200
            f.angle = 3.14
            return f.outputImage
            
        case .pinch:
            let f = CIFilter.pinchDistortion()
            f.inputImage = ciImage
            f.radius = 200
            f.scale = 0.5
            return f.outputImage
            
        case .bump:
            let f = CIFilter.bumpDistortion()
            f.inputImage = ciImage
            f.radius = 200
            f.scale = 0.5
            return f.outputImage
            
            // MARK: - 🎭 Stylize
        case .pixellate:
            let f = CIFilter.pixellate()
            f.inputImage = ciImage
            f.scale = 20
            return f.outputImage
            
        case .crystallize:
            let f = CIFilter.crystallize()
            f.inputImage = ciImage
            f.radius = 15
            return f.outputImage
            
        case .comic:
            let f = CIFilter.comicEffect()
            f.inputImage = ciImage
            return f.outputImage
            
            // MARK: - 📱 Presets
        case .noir:
            let f = CIFilter.photoEffectNoir()
            f.inputImage = ciImage
            return f.outputImage
            
        case .vivid:
            let f = CIFilter.photoEffectChrome()
            f.inputImage = ciImage
            return f.outputImage
            
        case .autoEnhance:
            let filters = ciImage.autoAdjustmentFilters()
            return filters.reduce(ciImage) { current, filter in
                filter.setValue(current, forKey: kCIInputImageKey)
                return filter.outputImage ?? current
            }
            
        case .original:
            return ciImage
        }
    }
}
