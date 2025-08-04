//
//  FindImageRouter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//

import UIKit

protocol IFindImageRouter: BaseRouting {}

final class FindImageRouter {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension FindImageRouter: IFindImageRouter {
    func routeTo(target: Any) {
        //
    }
}
