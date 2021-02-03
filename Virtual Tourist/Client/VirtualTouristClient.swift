//
//  VirtualTouristClient.swift
//  Virtual Tourist
//
//  Created by Roy Fuller on 1/31/21.
//

import Foundation

class VirtualTouristClient {
    enum Endpoints {
        static let base = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=4191ff8bedbf5dfe1e69e2428659eafb"
        
        case flickrSearchPhotos(String, String)
        
        var stringValue: String {
            switch self {
            case .flickrSearchPhotos(let lat, let lon): return Endpoints.base + "&lat=\(lat)&lon=\(lon)&format=json&nojsoncallback=1"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getPhotos(lat: String, lon: String, completionHandler: @escaping (String?, FlickrSearchPhotosResponse?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.flickrSearchPhotos(lat, lon).url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(error?.localizedDescription, nil)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(FlickrSearchPhotosResponse.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(nil, responseObject)
                }
            } catch {
                DispatchQueue.main.async {
                    completionHandler(error.localizedDescription, nil)
                }
                return
            }
        }
        task.resume()
    }

}
