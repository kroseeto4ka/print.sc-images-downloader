//
//  ImageCollectionViewController.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/5/25.
//

import UIKit

protocol IImageCollectionViewController: AnyObject {
}

final class ImageCollectionViewController: UICollectionViewController {
    enum Section {
        case main
    }
    
    var presenter: IImageCollectionPresenter?
    private var dataSource: UICollectionViewDiffableDataSource<Section, ImageModel>!
    
    private let cellIdentifier = "imageCollectionIdentifier"
    
    init(layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func presentImageDetailVC(imageModel: ImageModel) {
        let imageDetailVC = ImageDetailViewController(imageModel: imageModel)
        let imageDetailAssembly = ImageDetailAssembly(navigationController: self.presenter!.router.navigationController)
        imageDetailAssembly.configure(viewController: imageDetailVC)
        
        present(imageDetailVC, animated: true)
    }
    
}

//MARK: - Setup View
extension ImageCollectionViewController {
    func setupView() {
        collectionView.backgroundColor = .red
        collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: cellIdentifier)
    }
}

extension ImageCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfImages() ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ImageCollectionCell else {
            return UICollectionViewCell()
        }
        
        guard let images = self.presenter?.fetchAllImages() else {
            return UICollectionViewCell()
        }
        
        let imageModel = images[indexPath.item]
        
        cell.configure(imageModel)
        
        return cell
    }
}

extension ImageCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width * 0.42
        let height = width * 1.25
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidth = layout.itemSize.width
        let cellsPerRow = floor(collectionView.bounds.width / cellWidth)
        
        let totalCellWidth = cellsPerRow * cellWidth
        let totalSpacingWidth = (cellsPerRow - 1) * layout.minimumInteritemSpacing
        
        let sideInset = max(0, (collectionView.bounds.width - (totalCellWidth + totalSpacingWidth)) / 2)
        
        return UIEdgeInsets(top: 16, left: sideInset, bottom: 16, right: sideInset)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionCell {
            presentImageDetailVC(imageModel: cell.imageModel)
        }
    }
}


extension ImageCollectionViewController: IImageCollectionViewController {}
