//
//  ImageDetailAssembly.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 10/1/25.
//

import UIKit

final class ImageDetailAssembly {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension ImageDetailAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let imageDetailVC = viewController as? ImageDetailViewController else { return }
        let router = ImageDetailRouter(navigationController: navigationController)
        let presenter = ImageDetailPresenter(view: imageDetailVC as IImageDetailViewController,
                                           router: router, clipboardManager: ClipboardManager())
        
        imageDetailVC.presenter = presenter
    }
}
