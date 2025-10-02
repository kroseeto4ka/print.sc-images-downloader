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
    
    private func setupImageCollectionLayout() -> UICollectionViewFlowLayout  {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.9,
                                 height: 200)
        return layout
    }
}

extension FindImageRouter: IFindImageRouter {
    func routeTo(target: Any) {
        guard let imageCollectionTarget = target as? FindImageRouter.Target else { return }
        switch imageCollectionTarget {
        case .imageCollection:
            let layout = setupImageCollectionLayout()
            let imageCollectionVC = ImageCollectionViewController(layout: layout)
            let imageCollectionAssembly = ImageCollectionAssembly(navigationController: navigationController)
            imageCollectionAssembly.configure(viewController: imageCollectionVC)
            
            navigationController.pushViewController(imageCollectionVC, animated: true)
        }
    }
}
