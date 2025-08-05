//
//  ImageFetchManager.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/5/25.
//

import UIKit
import Foundation

protocol IImageFetchManager {
    func fetchRandomImage(completion: @escaping (ImageModel?) -> Void)
}

final class ImageFetchManager {
    private var randomImage = ImageModel()
    private let imageURLParser: IImageURLParser
    
    init() {
        self.imageURLParser = ImageURLParser()
    }
    
    private func generateRandomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
    
    private func downloadImage(from url: URL, completion: @escaping (ImageModel?) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                randomImage.error = "Download error: \(error.localizedDescription)"
                completion(randomImage)
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data),
                  image.size.width > 162, image.size.height > 82
            else {
                randomImage.error = "Error: Image is too small"
                completion(randomImage)
                return
            }
            randomImage.image = image
            randomImage.url = url.absoluteString
            
            completion(randomImage)
        }.resume()
    }
}

extension ImageFetchManager: IImageFetchManager {
    func fetchRandomImage(completion: @escaping (ImageModel?) -> Void) {
        randomImage = ImageModel()
        
        let baseURL = "https://prnt.sc/"
        let randomCode = generateRandomString(length: 6)
        let pageURLString = baseURL + randomCode
        
        guard let pageURL = URL(string: pageURLString) else {
            randomImage.error = "Wrong URL"
            completion(randomImage)
            return
        }
        
        URLSession.shared.dataTask(with: pageURL) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                randomImage.error = "Page download error: \(error.localizedDescription)"
                completion(randomImage)
                return
            }
            
            guard let data = data,
                  let html = String(data: data, encoding: .utf8),
                  let imageURL = imageURLParser.extractImageURL(from: html),
                  let imageDownloadURL = URL(string: imageURL)
            else {
                randomImage.error = "Error: Couldn't find image"
                completion(randomImage)
                return
            }
            
            self.downloadImage(from: imageDownloadURL, completion: completion)
        }.resume()
    }
}
