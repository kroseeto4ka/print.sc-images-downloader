//
//  ImageCollectionRouter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/5/25.
//

import UIKit

protocol IImageCollectionRouter {
    
}

class ImageCollectionRouter {
    enum Target {
        case findImage
    }
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension ImageCollectionRouter: IImageCollectionRouter {
    
}
