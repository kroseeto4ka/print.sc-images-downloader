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
    func runImageCollectionFlow()
    func saveImage()
}

final class FindImagePresenter {
    private weak var view: IFindImageViewController!
    let router: IFindImageRouter
    private let imageFetchManager: IImageFetchManager
    private let clipboardManager: IClipboardManager
    private let imageStore: IImageStoreManager
    private var currentImage: ImageModel?
    
    init(view: IFindImageViewController,
         router: IFindImageRouter,
         fetchManager: IImageFetchManager,
         clipboardManager: IClipboardManager,
         imageStore: IImageStoreManager) {
        self.router = router
        self.view = view
        self.imageFetchManager = fetchManager
        self.clipboardManager = clipboardManager
        self.imageStore = imageStore
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
    
    func saveImage() {
        guard let image = currentImage else {
            view.display(error: "Couldn't save data")
            return
        }
        imageStore.save(image)
    }
    
    func fetchRandomImage() {
        DispatchQueue.main.async {
            self.view?.displayLoading()
        }
        
        imageFetchManager.fetchRandomImage { [weak self] randomImage in
            guard let randomImage = randomImage else {
                return
            }
            
            if let _ = randomImage.image {
                // ✅ Успешная картинка
                self?.currentImage = randomImage
                DispatchQueue.main.async {
                    self?.view?.display(imageModel: randomImage)
                }
            } else {
                // ❌ Ошибка
                self?.currentImage = randomImage
                DispatchQueue.main.async {
                    self?.view?.display(error: randomImage.error ?? "Unknown error")
                }
            }
        }
    }
    
    func runImageCollectionFlow() {
        if imageStore.getAmount() == 0 {
            return
        }
        
        router.routeTo(target: FindImageRouter.Target.imageCollection)
    }
    
    func getSavedImagesAmount() -> Int {
        imageStore.getAmount()
    }
}
