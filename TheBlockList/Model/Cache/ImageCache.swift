//
//  ImageCache.swift
//  TheBlockList
//
//  Created by Wellison Pereira on 2/21/22.
//

import UIKit

public typealias ImageCompletion = (UIImage?) -> ()

/// A class that handles image caching for efficient data usage. This class was modeled after Apple's example.
/// https://developer.apple.com/documentation/uikit/views_and_controls/table_views/asynchronously_loading_images_into_table_and_collection_views
public final class ImageCache {
    
    // MARK: - Singleton Instance
    
    public static let shared = ImageCache()
    
    // MARK: - Private Variables
    
    private let cachedImages = NSCache<NSURL, UIImage>()
    private var loadingResponses = [NSURL: [ImageCompletion]]()
    
    // MARK: - Public Methods
    
    /// A method that will load an image, starting with the cache, ending with a network request if needed.
    public func load(url: NSURL, completion: @escaping ImageCompletion) {
        // Start by checking if there is a cached image from the provided url.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        
        // Lastly, fetch the image.
        URLSession(configuration: .ephemeral).dataTask(with: url as URL) { [weak self] data, response, error in

            // Check for the error, then data and try to create the image.
            guard let self = self, let data = data, let image = UIImage(data: data), let blocks = self.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            // Cache the image.
            self.cachedImages.setObject(image, forKey: url, cost: data.count)
            
            // Iterate over each requestor for the image and pass it back.
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
                return
            }
        }.resume()
    }
    
    // MARK: - Private Methods
    
    /// Attempts to fetch an image from the cache.
    private func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
}
