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
}

final class ImageDetailPresenter {
    weak var view: IImageDetailViewController!
    var router: IImageDetailRouter
    private let clipboardManager: IClipboardManager
    
    init(view: IImageDetailViewController, router: IImageDetailRouter, clipboardManager: IClipboardManager) {
        self.view = view
        self.router = router
        self.clipboardManager = clipboardManager
    }
}

extension ImageDetailPresenter: IImageDetailPresenter {
    func copyTappedImage(image: UIImage?) {
        clipboardManager.copyTappedImage(image: image)
    }
    
    func copyTappedURL(url: String?) {
        clipboardManager.copyTappedURL(url: url)
    }
}
