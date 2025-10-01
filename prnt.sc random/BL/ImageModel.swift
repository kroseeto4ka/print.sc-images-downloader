//
//  ImageModel.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/4/25.
//

import UIKit
import Foundation

struct ImageModel {
    var url: String?
    var image: Data?
    var error: String?
}

extension ImageModel: Equatable {}

extension ImageModel: Codable {}

extension ImageModel: Hashable {}
