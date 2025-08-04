//
//  MVXProtocol.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//
import UIKit

protocol BaseAssembly {
    func configure(viewController: UIViewController)
}

protocol BaseRouting {
    init(navigationController: UINavigationController)
    func routeTo(target: Any)
}
