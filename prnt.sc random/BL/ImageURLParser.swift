//
//  ImageURLParser.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/5/25.
//

import Foundation
import UIKit

protocol IImageURLParser {
    func extractImageURL(from html: String) -> String?
}

final class ImageURLParser {}

extension ImageURLParser: IImageURLParser {
    func extractImageURL(from html: String) -> String? {
        let pattern = "<img[^>]+src\\s*=\\s*\"(https://[^\">]+)\""
        if let regex = try? NSRegularExpression(pattern: pattern, options: []),
           let match = regex.firstMatch(in: html, options: [], range: NSRange(location: 0, length: html.utf16.count)),
           let range = Range(match.range(at: 1), in: html) {
            return String(html[range])
        }
        return nil
    }
}
