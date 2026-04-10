//
//  FilterProvider.swift
//  FilterPhoto
//
//  Created by Grigory G. on 02.06.23.
//

// MARK: - Filters Provider
enum FilterProvider {
    
    // MARK: - All Filters
    static var all: [Filter] {
        [
            // 🎨 Color
            Filter(id: "1", title: "Color Matrix", type: .colorMatrix),
            Filter(id: "2", title: "Color Controls", type: .colorControls),
            Filter(id: "3", title: "Hue Adjust", type: .hueAdjust),
            Filter(id: "4", title: "Vibrance", type: .vibrance),
            Filter(id: "5", title: "Sepia", type: .sepia),
            
            // ⚙️ Adjustments
            Filter(id: "6", title: "Exposure", type: .exposure),
            Filter(id: "7", title: "Brightness", type: .brightness),
            Filter(id: "8", title: "Contrast", type: .contrast),
            Filter(id: "9", title: "Gamma", type: .gamma),
            
            // 🌫 Blur
            Filter(id: "10", title: "Gaussian Blur", type: .gaussianBlur),
            Filter(id: "11", title: "Motion Blur", type: .motionBlur),
            Filter(id: "12", title: "Zoom Blur", type: .zoomBlur),
            
            // 🌀 Distortion
            Filter(id: "13", title: "Twirl", type: .twirl),
            Filter(id: "14", title: "Pinch", type: .pinch),
            Filter(id: "15", title: "Bump", type: .bump),
            
            // 🎭 Stylize
            Filter(id: "16", title: "Pixellate", type: .pixellate),
            Filter(id: "17", title: "Crystallize", type: .crystallize),
            Filter(id: "18", title: "Comic", type: .comic),
            
            // 📱 UI
            Filter(id: "19", title: "Original", type: .original),
            Filter(id: "20", title: "Auto Enhance", type: .autoEnhance),
            Filter(id: "21", title: "Vivid", type: .vivid),
            Filter(id: "22", title: "Noir", type: .noir)
        ]
        
    }
}
