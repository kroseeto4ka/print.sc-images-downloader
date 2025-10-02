//
//  ImageDetailViewController.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 10/1/25.
//

import UIKit

protocol IImageDetailViewController: AnyObject {
}

final class ImageDetailViewController: UIViewController {
    
    private let image = UIImageView()
    private let infoLabel = UILabel()
    private let imageModel: ImageModel
    
    var presenter: IImageDetailPresenter?
    
    init(imageModel: ImageModel) {
        self.imageModel = imageModel
        image.image = UIImage(data: imageModel.image ?? Data())
        infoLabel.text = imageModel.url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
}

// MARK: - View Setup
private extension ImageDetailViewController {
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(image)
        view.addSubview(infoLabel)
        
        setupInfoLabel()
        setupGestureRecognizers()
    }
    
    func setupGestureRecognizers() {
        let imageTap = UILongPressGestureRecognizer(target: self, action: #selector(handleImagePress(_:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(imageTap)
        
        let labelTap = UILongPressGestureRecognizer(target: self, action: #selector(handleLabelPress(_:)))
        infoLabel.isUserInteractionEnabled = true
        infoLabel.addGestureRecognizer(labelTap)
    }
    
    @objc private func handleImagePress(_ sender: UITapGestureRecognizer) {
        guard sender.state == .began else { return }
        presenter?.copyTappedImage(image: self.image.image)
    }
    
    @objc private func handleLabelPress(_ sender: UITapGestureRecognizer) {
        guard sender.state == .began else { return }
        presenter?.copyTappedURL(url: infoLabel.text)
    }
    
    func setupInfoLabel() {
        infoLabel.font = .systemFont(ofSize: 20, weight: .light)
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
    }
    
    func clearScreen() {
        image.image = .none
        infoLabel.isHidden = true
        
        infoLabel.isUserInteractionEnabled = false
        image.isUserInteractionEnabled = false
    }
}

// MARK: - View Layout
private extension ImageDetailViewController {
    func setupLayout() {
        [image, infoLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
            image.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            
            infoLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
            infoLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
        ])
    }
}

extension ImageDetailViewController: IImageDetailViewController {
    
}
