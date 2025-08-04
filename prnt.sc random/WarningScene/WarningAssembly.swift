//
//  WarningAssembly.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//
import UIKit

final class WarningAssembly {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension WarningAssembly: BaseAssembly {
    func configure(viewController: UIViewController) {
        guard let warningVC = viewController as? WarningViewController else { return }
        let router = WarningRouter(navigationController: navigationController)
        let presenter = WarningPresenter(router: router)
        
        warningVC.presenter = presenter
        presenter.view = warningVC //as? any IWarningViewController
    }
}
