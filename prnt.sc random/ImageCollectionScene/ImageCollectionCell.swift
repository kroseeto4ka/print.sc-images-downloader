//
//  ImageCollectionCell.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/8/25.
//

import UIKit

final class ImageCollectionCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    let urlLabel = UILabel()
    let imageErrorLabel = {
        let error = UILabel()
        error.text = "Error: no image"
        error.textAlignment = .center
        error.textColor = .blue
        error.font = .systemFont(ofSize: 20, weight: .bold)
        error.isHidden = true
        return error
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupUrl()
        setupImage() //FIXME: - менять модель или менять врап
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        urlLabel.text = nil
    }
    
    func configure(_ imageModel: ImageModel) {
        urlLabel.text = imageModel.url
        
        if let data = imageModel.image, let image = UIImage(data: data) {
            imageView.image = image
            imageErrorLabel.isHidden = true
        } else {
            imageView.image = nil
            imageErrorLabel.isHidden = false
        }
    }
}

//MARK: - Setup View
extension ImageCollectionCell {
    private func setupView() {
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 20
        contentView.addSubview(imageView)
        contentView.addSubview(urlLabel)
        contentView.addSubview(imageErrorLabel)
    }
    
    private func setupUrl() {
        urlLabel.numberOfLines = 0
        urlLabel.textAlignment = .left
        urlLabel.font = .systemFont(ofSize: 15, weight: .light)
    }
    
    private func setupImage() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
    }
}

//MARK: - Setup Layout
extension ImageCollectionCell {
    private func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        imageErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            imageErrorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageErrorLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
            imageErrorLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            imageErrorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            
            urlLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            urlLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.85),
            urlLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            urlLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
