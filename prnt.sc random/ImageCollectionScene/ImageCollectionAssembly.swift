//
//  ImageCollectionAssembly.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/5/25.
//

import UIKit

final class ImageCollectionAssembly {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension ImageCollectionAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let imageCollectionVC = viewController as? ImageCollectionViewController else { return }
        let router = ImageCollectionRouter(navigationController: navigationController)
        let presenter = ImageCollectionPresenter(view: imageCollectionVC,
                                           router: router)
        
        imageCollectionVC.presenter = presenter
    }
}
