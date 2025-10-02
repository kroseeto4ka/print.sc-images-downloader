//
//  ViewController.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 6/18/25.
//

import UIKit

protocol IFindImageViewController: AnyObject {
    func display(imageModel: ImageModel)
    func display(error: String)
    func displayLoading()
}

final class FindImageViewController: UIViewController {
    
    private let tryButton = UIButton()
    private let saveButton = UIButton()
    private let galleryButton = UIButton()
    
    private let buttonStack = UIStackView()
    private let image = UIImageView()
    private let infoLabel = UILabel()
    
    var presenter: IFindImagePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }


}

// MARK: - View Setup
private extension FindImageViewController {
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(tryButton)
        view.addSubview(image)
        view.addSubview(infoLabel)
        view.addSubview(buttonStack)
        
        setupInfoLabel()
        setupAction()
        setupButtonStack()
        setupGestureRecognizers()
    }
    
    func setupButtonStack() {
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalCentering
        buttonStack.spacing = 20
        
        [saveButton, tryButton, galleryButton].forEach { button in
            buttonStack.addArrangedSubview(button)
        }
        
        setupTryButton()
        setupSaveButton()
        setupGalleryButton()
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
    
    func setupTryButton() {
        tryButton.setTitle("Try!", for: .normal)
        tryButton.backgroundColor = .red
        tryButton.layer.cornerRadius = 20
    }
    
    func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .green
        saveButton.layer.cornerRadius = 20
    }
    
    func setupGalleryButton() {
        galleryButton.setTitle("Gallery", for: .normal)
        galleryButton.backgroundColor = .orange
        galleryButton.layer.cornerRadius = 20
    }
    
    func setupInfoLabel() {
        infoLabel.isHidden = true
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
    
    func disableButton() {
        tryButton.isEnabled = false
        tryButton.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.tryButton.isEnabled = true
            self.tryButton.alpha = 1
        }
    }
    
    func tryAction() {
        self.clearScreen()
        self.disableButton()
        self.presenter?.fetchRandomImage()
    }
    
    func saveAction() {
        self.presenter?.saveImage()
    }
    
    func galleryAction() {
        self.presenter?.runImageCollectionFlow()
    }
    
    func setupAction() {
        let saveAction = UIAction { _ in
            self.saveAction()
        }
        let tryAction = UIAction { _ in
            self.tryAction()
        }
        
        let galleryAction = UIAction { _ in
            self.galleryAction()
        }
        
        saveButton.addAction(saveAction, for: .touchUpInside)
        tryButton.addAction(tryAction, for: .touchUpInside)
        galleryButton.addAction(galleryAction, for: .touchUpInside)
    }
}

// MARK: - View Layout
private extension FindImageViewController {
    func setupLayout() {
        [tryButton, saveButton, galleryButton, image, infoLabel, buttonStack].forEach { view in
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
            infoLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            buttonStack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            buttonStack.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            buttonStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tryButton.heightAnchor.constraint(equalTo: buttonStack.heightAnchor),
            tryButton.widthAnchor.constraint(equalToConstant: 100),
            
            saveButton.heightAnchor.constraint(equalTo: buttonStack.heightAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            
            galleryButton.heightAnchor.constraint(equalTo: buttonStack.heightAnchor),
            galleryButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}

//MARK: - IFindImageViewController
extension FindImageViewController: IFindImageViewController {
    func display(imageModel: ImageModel) {
        self.image.image = UIImage(data: imageModel.image ?? Data())
        self.image.isUserInteractionEnabled = true
        
        self.infoLabel.text = imageModel.url
        self.infoLabel.isHidden = false
        self.infoLabel.textColor = .gray
        self.infoLabel.isUserInteractionEnabled = true
    }
    
    func display(error: String) {
        self.infoLabel.text = error
        self.infoLabel.textColor = .red
        self.infoLabel.isHidden = false
    }
    
    func displayLoading() {
        infoLabel.isHidden = false
        infoLabel.textColor = .cyan
        infoLabel.text = "Loading..."
    }
}
