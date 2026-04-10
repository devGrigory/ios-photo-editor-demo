//
//  PhotoEditorModel.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//


import UIKit

// MARK: - Model
enum PhotoEditorModel {
    
    // MARK: - Show Filtered Photo
    enum ShowPhoto {
        struct Request {
            let image: UIImage?
        }
        
        struct Response {
            let image: UIImage?
        }
        
        struct ViewModel {
            let image: UIImage?
        }
    }
    
    // MARK: - Apply Filter (user action)
    enum ApplyFilter {
        struct Request {
            let image: UIImage?
            let filter: Filter
        }
        
        struct Response {
            let image: UIImage?
        }
        
        struct ViewModel {
            let image: UIImage?
        }
    }
}
