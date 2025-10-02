//
//  ImageCollectionRouter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/5/25.
//

import UIKit

protocol IImageCollectionRouter {
    var navigationController: UINavigationController { get }
}

class ImageCollectionRouter {
    enum Target {
        case imageDetail
    }
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension ImageCollectionRouter: IImageCollectionRouter {}
