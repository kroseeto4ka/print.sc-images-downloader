//
//  ImageDetailRouter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 10/1/25.
//

import UIKit

protocol IImageDetailRouter {
    
}

class ImageDetailRouter {
    enum Target {
        case findImage
    }
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

}

extension ImageDetailRouter: IImageDetailRouter {
    
}
