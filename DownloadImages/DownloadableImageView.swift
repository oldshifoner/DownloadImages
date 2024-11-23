//
//  DownloadableImageView.swift
//  DownloadImages
//
//  Created by Максим Игоревич on 23.11.2024.
//

import UIKit

class DownloadableImageView: UIImageView, Downloadable {
    private static let memoryCache = NSCache<NSString, UIImage>()
    private static let diskCacheURL: URL = {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }()

    public func loadImage(from url: URL, withOptions: [DownloadOptions]) {
        DispatchQueue.global().async {
            var processedImage: UIImage?
            
            if let cachedImage = self.getCachedImage(for: url, options: withOptions) {
                processedImage = cachedImage
            } else {
                guard let data = try? Data(contentsOf: url),
                      var image = UIImage(data: data) else {
                    return
                }
                for option in withOptions {
                    image = self.performOption(image, option: option, for: url)
                }
                print("downLOAD")
               // self.cacheImage(image, for: url)
                processedImage = image
            }
            
            DispatchQueue.main.async {
                self.image = processedImage
            }
        }
    }
    
    private func getCachedImage(for url: URL, options: [DownloadOptions]) -> UIImage?{
        for option in options {
            switch option {
            case .cache(let from):
                let key = cacheKey(for: url)
                switch from {
                    case .disk:
                        let diskURL = DownloadableImageView.diskCacheURL.appendingPathComponent(key)
                        if let diskImage = UIImage(contentsOfFile: diskURL.path) {
                            return diskImage
                        }
                        print("key disk = " + key)
                    case .memory:
                        if let cachedImage = DownloadableImageView.memoryCache.object(forKey: key as NSString) {
                            return cachedImage
                        }
                        print("key memory = " + key)
                }
            default: break
            }
        }
        return nil
    }
    
    
    private func performOption(_ image: UIImage, option: DownloadOptions, for url: URL) -> UIImage {
        switch option {
        case .circle:
            return image.makeCircular()
        case .resize(let size):
            return image.resized(to: size)
        case .cache(let from):
            let key = cacheKey(for: url)
            switch from{
                case .disk:
                    let diskURL = DownloadableImageView.diskCacheURL.appendingPathComponent(key)
                    if let data = image.pngData() {
                        try? data.write(to: diskURL)
                    }
                case .memory:
                    DownloadableImageView.memoryCache.setObject(image, forKey: key as NSString)
            }
            return image
        }
    }
//
//    private func cacheImage(_ image: UIImage, for url: URL) {
//        let key = cacheKey(for: url)
//        DownloadableImageView.memoryCache.setObject(image, forKey: key as NSString)
//
//        let diskURL = DownloadableImageView.diskCacheURL.appendingPathComponent(key)
//        if let data = image.pngData() {
//            try? data.write(to: diskURL)
//        }
//    }

    private func cacheKey(for url: URL) -> String {
        return "\(url.absoluteString)"
    }
}

enum DownloadOptions {
    enum From {
        case memory
        case disk
    }
    case circle
    case cache(From)
    case resize(CGSize)
}
protocol Downloadable {
    func loadImage(from url: URL, withOptions: [DownloadOptions])
}
