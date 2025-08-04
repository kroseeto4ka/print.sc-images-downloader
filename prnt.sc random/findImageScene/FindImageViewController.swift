//
//  ViewController.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 6/18/25.
//

import UIKit

protocol IFindImageViewController: AnyObject {
    func display(image: UIImage, url: URL)
    func display(error: String)
    func displayLoading()
}

final class FindImageViewController: UIViewController {
    
    private let tryButton = UIButton()
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
        setupTryButton()
        setupInfoLabel()
        setupAction()
    }
    
    func setupTryButton() {
        tryButton.setTitle("Try!", for: .normal)
        tryButton.backgroundColor = .red
        tryButton.layer.cornerRadius = 20
    }
    
    func setupInfoLabel() {
        infoLabel.isHidden = true
        infoLabel.font = .systemFont(ofSize: 20, weight: .light)
        infoLabel.textAlignment = .center
        
    }
    
    func clearScreen() {
        image.image = .none
        infoLabel.isHidden = true
    }
    
    func setupAction() {
        let tryAction = UIAction { _ in
            self.clearScreen()
            self.presenter?.fetchRandomImage()
        }
        
        tryButton.addAction(tryAction, for: .touchUpInside)
    }
}

// MARK: - View Layout
private extension FindImageViewController {
    func setupLayout() {
        tryButton.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
            image.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.4),
            
            infoLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 50),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
            infoLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            
            tryButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            tryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            tryButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            tryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension FindImageViewController: IFindImageViewController {
    func display(image: UIImage, url: URL) {
        self.image.image = image
        
        self.infoLabel.text = url.absoluteString
        self.infoLabel.isHidden = false
        self.infoLabel.textColor = .gray
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
