//
//  WarningRouter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//

import UIKit

protocol IWarningRouter: BaseRouting {
    
}

final class WarningRouter {
    enum Target {
        case findImage
    }
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension WarningRouter: IWarningRouter {
    func routeTo(target: Any) {
        guard let warningTarget = target as? WarningRouter.Target else { return }
        switch warningTarget {
        case .findImage:
            let findImageVC = FindImageViewController()
            let findImageAssembly = FindImageAssembly(navigationController: navigationController)
            findImageAssembly.configure(viewController: findImageVC)
            
            navigationController.pushViewController(findImageVC, animated: true)
        }
    }
}
