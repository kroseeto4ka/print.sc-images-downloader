//
//  WarningViewController.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//

import UIKit

protocol IWarningViewController: AnyObject {}

final class WarningViewController: UIViewController {
    
    private let warningTitle = UILabel()
    private let warningText = UILabel()
    private let agreeButton = UIButton()
    
    var presenter: IWarningPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

}

//MARK: - Setup View
private extension WarningViewController {
    func setupView() {
        view.backgroundColor = .white
        [agreeButton, warningTitle, warningText].forEach { label in
            view.addSubview(label)
        }
        setupTitle()
        setupText()
        setupButton()
        addAction()
    }
    
    func setupTitle() {
        warningTitle.text = Warnings.title
        warningTitle.font = .systemFont(ofSize: 60, weight: .medium)
        warningTitle.textColor = .red
    }
    
    func setupText() {
        warningText.text = Warnings.mainText
        warningText.font = .systemFont(ofSize: 25, weight: .light)
        warningText.textColor = .gray
        warningText.numberOfLines = 7
        warningText.textAlignment = .natural
    }
    
    func setupButton() {
        agreeButton.setTitle("Agree", for: .normal)
        agreeButton.titleLabel?.font = .systemFont(ofSize: 30, weight: .heavy)
        agreeButton.backgroundColor = .cyan
        agreeButton.layer.cornerRadius = 20
    }
    
    func agreeActionSetup() {
        presenter?.runFindImageFlow()
    }
    
    func addAction() {
        let agreeAction = UIAction { _ in
            self.agreeActionSetup()
        }
        
        agreeButton.addAction(agreeAction, for: .touchUpInside)
    }
}

//MARK: - Setup Layout
private extension WarningViewController {
    private func setupLayout() {
        [agreeButton, warningTitle, warningText].forEach { label in
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            warningTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            warningTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            warningText.topAnchor.constraint(equalTo: warningTitle.bottomAnchor, constant: 50),
            warningText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningText.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            
            agreeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            agreeButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            agreeButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7),
            agreeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -90)
        ])
    }
}

//MARK: - IWarningViewController
extension WarningViewController: IWarningViewController {
    
}

//MARK: - Warnings Enum
enum Warnings {
    static let title: String = "Warning"
    static let mainText: String = "Content on this page is provided via prnt.sc. The nature of content can be any kind, search on your own risk."
}
