//
//  FindImageAssembly.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//
import UIKit

final class FindImageAssembly {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension FindImageAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let findImageVC = viewController as? FindImageViewController else { return }
        let router = FindImageRouter(navigationController: navigationController)
        let fetchManager = ImageFetchManager()
        let clipboardManager = ClipboardManager()
        let storeManager = ImageStoreManager()
        let presenter = FindImagePresenter(view: findImageVC,
                                           router: router,
                                           fetchManager: fetchManager,
                                           clipboardManager: clipboardManager,
                                           imageStore: storeManager)
        
        findImageVC.presenter = presenter
    }
}
