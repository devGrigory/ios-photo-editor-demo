//
//  PhotosModel.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

import UIKit

// MARK: - Typealiases
// typealias PhotosResponse = [PhotoModel.FetchPhotosList.Response]
// typealias ...
// typealias ...
// typealias ...

// MARK: - PhotoModel
enum PhotosModel {
    
    // MARK: - FetchPhotosList
    enum FetchPhotosList {
        
        struct Request {
            
        }
        
        struct Response: Decodable {
            
            let id: String
            let author: String
            let downloadURL: String
            
            // MARK: - CodingKeys
            private enum CodingKeys: String, CodingKey {
                case id
                case author
                case downloadURL = "download_url"
            }
        }
        
        struct ViewModel {
            let imageURLs: [String]
        }
    }
    
    // MARK: - SelectedPhoto
    enum SelectedPhoto {
        struct Request {
            let url: URL
        }
        
        struct Response {
            let image: UIImage
        }
        
        struct ViewModel {
            let image: UIImage
        }
    }
}
