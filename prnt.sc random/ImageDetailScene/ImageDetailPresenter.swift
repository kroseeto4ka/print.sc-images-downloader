//
//  ImageDetailPresenter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 10/1/25.
//
import UIKit.UIImage

protocol IImageDetailPresenter {
    func copyTappedImage(image: UIImage?)
    func copyTappedURL(url: String?)
    func deleteImage(imageModel: ImageModel)
}

final class ImageDetailPresenter {
    weak var view: IImageDetailViewController!
    var router: IImageDetailRouter
    
    private let clipboardManager: IClipboardManager
    private let storeManager: ImageStoreManager
    
    init(view: IImageDetailViewController,
         router: IImageDetailRouter,
         clipboardManager: IClipboardManager,
         storeManager: ImageStoreManager) {
        self.view = view
        self.router = router
        self.clipboardManager = clipboardManager
        self.storeManager = storeManager
    }
}

extension ImageDetailPresenter: IImageDetailPresenter {
    func copyTappedImage(image: UIImage?) {
        clipboardManager.copyTappedImage(image: image)
    }
    
    func copyTappedURL(url: String?) {
        clipboardManager.copyTappedURL(url: url)
    }
    
    func deleteImage(imageModel: ImageModel) {
        storeManager.delete(imageModel)
    }
}
