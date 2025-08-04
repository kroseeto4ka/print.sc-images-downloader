//
//  FindImagePresenter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//

import Foundation
import UIKit

protocol IFindImagePresenter {
    func fetchRandomImage()
    func copyTappedImage(image: UIImage?)
    func copyTappedURL(url: String?)
}

final class FindImagePresenter {
    private weak var view: IFindImageViewController!
    let router: IFindImageRouter
    private var randomImage: ImageModel?
    
    init(view: IFindImageViewController, router: IFindImageRouter) {
        self.router = router
        self.view = view
        randomImage = ImageModel()
    }
}

//MARK: - Supportive Functions
private extension FindImagePresenter {
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                randomImage?.error = "Download error: \(error.localizedDescription)"
                DispatchQueue.main.async {
                    self.view?.display(error: (self.randomImage?.error)!)
                }
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data),
                  image.size.width > 162, image.size.height > 82
            else {
                randomImage?.error = "Error: Image is too small"
                DispatchQueue.main.async {
                    self.view?.display(error: (self.randomImage?.error)!)
                }
                return
            }
            randomImage?.image = image
            randomImage?.url = url.absoluteString
            
            DispatchQueue.main.async {
                self.view?.display(imageModel: self.randomImage!)
            }
        }.resume()
    }
    
    private func generateRandomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyz0123456789"
        return String((0..<length).compactMap { _ in characters.randomElement() })
    }
    
    private func extractImageURL(from html: String) -> String? {
        let pattern = "<img[^>]+src\\s*=\\s*\"(https://[^\">]+)\""
        if let regex = try? NSRegularExpression(pattern: pattern, options: []),
           let match = regex.firstMatch(in: html, options: [], range: NSRange(location: 0, length: html.utf16.count)),
           let range = Range(match.range(at: 1), in: html) {
            return String(html[range])
        }
        return nil
    }
}

//MARK: - IFindImagePresenter
extension FindImagePresenter: IFindImagePresenter {
    func copyTappedImage(image: UIImage?) {
        guard let image = image else { return }
        UIPasteboard.general.image = image
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
    }
    
    func copyTappedURL(url: String?) {
        guard let url = url else { return }
        if !url.isEmpty {
            UIPasteboard.general.string = url
        }
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
    }
    
    func fetchRandomImage() {
        DispatchQueue.main.async {
            self.view?.displayLoading()
        }
        
        let baseURL = "https://prnt.sc/"
        let randomCode = generateRandomString(length: 6)
        let pageURLString = baseURL + randomCode
        
        guard let pageURL = URL(string: pageURLString) else {
            randomImage?.error = "Wrong URL"
            DispatchQueue.main.async {
                self.view?.display(error: (self.randomImage?.error)!)
            }
            return
        }
        
        URLSession.shared.dataTask(with: pageURL) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                randomImage?.error = "Page download error: \(error.localizedDescription)"
                DispatchQueue.main.async {
                    self.view?.display(error: (self.randomImage?.error)!)
                }
                return
            }
            
            guard let data = data,
                  let html = String(data: data, encoding: .utf8),
                  let imageURL = extractImageURL(from: html),
                  let imageDownloadURL = URL(string: imageURL)
            else {
                randomImage?.error = "error: Couldn't find image"
                DispatchQueue.main.async {
                    self.view?.display(error: (self.randomImage?.error)!)
                }
                return
            }
            
            self.downloadImage(from: imageDownloadURL)
        }.resume()
    }
}
