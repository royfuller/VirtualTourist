//
//  FlickrSearchPhotosResponse.swift
//  Virtual Tourist
//
//  Created by Roy Fuller on 2/1/21.
//

import Foundation

struct FlickrSearchPhotosResponse: Codable {
    let photos: Photos
    let stat: String
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [Photograph]
}

struct Photograph: Codable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ispublic: Int
    let isfriend: Int
    let isfamily: Int
}
