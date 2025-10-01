//
//  FindImageRouter.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//

import UIKit

protocol IFindImageRouter: BaseRouting {}

final class FindImageRouter {
    enum Target {
        case imageCollection
    }
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension FindImageRouter: IFindImageRouter {
    func routeTo(target: Any) {
        print("routeTo")
        guard let imageCollectionTarget = target as? FindImageRouter.Target else { return }
        switch imageCollectionTarget {
        case .imageCollection:
            let layout = UICollectionViewFlowLayout()
            
            layout.itemSize = CGSize(width: 200, height: 200)
            layout.minimumLineSpacing = 100
            layout.minimumInteritemSpacing = 1
            layout.scrollDirection = .vertical
            
            let imageCollectionVC = ImageCollectionViewController(layout: layout)
            let imageCollectionAssembly = ImageCollectionAssembly(navigationController: navigationController)
            imageCollectionAssembly.configure(viewController: imageCollectionVC)
            
            navigationController.pushViewController(imageCollectionVC, animated: true)
        }
        
    }
}
