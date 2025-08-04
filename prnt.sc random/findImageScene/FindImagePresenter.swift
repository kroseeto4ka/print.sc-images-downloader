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
    
}

final class FindImagePresenter {
    private weak var view: IFindImageViewController!
    let router: IFindImageRouter
    
    init(view: IFindImageViewController, router: IFindImageRouter) {
        self.router = router
        self.view = view
    }
}

//MARK: - Supportive Functions
private extension FindImagePresenter {
    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.view?.display(error: "Download error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data),
                  image.size.width > 10, image.size.height > 10
            else {
                DispatchQueue.main.async {
                    self.view?.display(error: "Error: Image is too small")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.view?.display(image: image, url: url)
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
    func fetchRandomImage() {
        DispatchQueue.main.async {
            self.view?.displayLoading()
        }
        
        let baseURL = "https://prnt.sc/"
        let randomCode = generateRandomString(length: 6)
        let pageURLString = baseURL + randomCode
        
        guard let pageURL = URL(string: pageURLString) else {
            DispatchQueue.main.async {
                self.view?.display(error: "Wrong URL")
            }
            return
        }
        
        URLSession.shared.dataTask(with: pageURL) { [weak self] data, _, error in
            guard let self = self else { return }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.view?.display(error: "Page download error: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data,
                  let html = String(data: data, encoding: .utf8),
                  let imageURL = extractImageURL(from: html),
                  let imageDownloadURL = URL(string: imageURL)
            else {
                DispatchQueue.main.async {
                    self.view?.display(error: "Couldn't find image")
                }
                return
            }
            
            self.downloadImage(from: imageDownloadURL)
        }.resume()
    }
}
