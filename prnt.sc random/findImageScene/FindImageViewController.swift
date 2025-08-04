//
//  ViewController.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 6/18/25.
//

import UIKit

protocol IFindImageViewController: AnyObject {
    
}

final class FindImageViewController: UIViewController {
    
    private let tryButton = UIButton()
    private let image = UIImage()
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
        setupTryButton()
        setupAction()
    }
    
    func setupTryButton() {
        tryButton.setTitle("Try!", for: .normal)
        tryButton.backgroundColor = .red
        tryButton.layer.cornerRadius = 20
    }
    
    func setupAction() {
        let tryAction = UIAction { _ in
            print("aboba123")
        }
        
        tryButton.addAction(tryAction, for: .touchUpInside)
    }
}

// MARK: - View Layout

private extension FindImageViewController {
    func setupLayout() {
        tryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tryButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            tryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            tryButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            tryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension FindImageViewController: IFindImageViewController {}
