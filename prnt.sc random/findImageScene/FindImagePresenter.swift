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
    private let imageFetchManager: IImageFetchManager
    private let clipboardManager: IClipboardManager
    
    init(view: IFindImageViewController,
         router: IFindImageRouter,
         fetchManager: IImageFetchManager,
         clipboardManager: IClipboardManager) {
        self.router = router
        self.view = view
        self.imageFetchManager = fetchManager
        self.clipboardManager = clipboardManager
    }
}

//MARK: - IFindImagePresenter
extension FindImagePresenter: IFindImagePresenter {
    func copyTappedImage(image: UIImage?) {
        clipboardManager.copyTappedImage(image: image)
    }
    
    func copyTappedURL(url: String?) {
        clipboardManager.copyTappedURL(url: url)
    }
    
    func fetchRandomImage() {
        DispatchQueue.main.async {
            self.view?.displayLoading()
        }
        
        imageFetchManager.fetchRandomImage { [weak self] randomImage in
            guard let randomImage = randomImage else {
                return
            }
            
            guard randomImage.image == nil else {
                DispatchQueue.main.async {
                    self?.view?.display(imageModel: randomImage)
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.view?.display(error: randomImage.error ?? "Error unwrapping error")
            }
        }
    }
}
