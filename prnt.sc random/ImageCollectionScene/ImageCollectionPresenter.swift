//
//  ImageCollectionPresenter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/5/25.
//

protocol IImageCollectionPresenter {
    var router: IImageCollectionRouter { get }
    func numberOfImages() -> Int
    func fetchAllImages() -> [ImageModel]
}

final class ImageCollectionPresenter {
    weak var view: IImageCollectionViewController!
    var router: IImageCollectionRouter
    let imageStore = ImageStoreManager() //FIXME: - add external manager init
    
    init(view: IImageCollectionViewController, router: IImageCollectionRouter) {
        self.view = view
        self.router = router
    }
}

extension ImageCollectionPresenter: IImageCollectionPresenter {
    func fetchAllImages() -> [ImageModel] {
        return imageStore.fetchAll()
    }
    
    func numberOfImages() -> Int {
        imageStore.getAmount()
    }
}
