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
        print("количество ячеек: \(presenter?.numberOfImages() ?? 0)")///DEBUG
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

extension ImageCollectionViewController: IImageCollectionViewController {}
