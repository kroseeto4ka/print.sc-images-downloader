//
//  ClipboardManager.swift
//  prnt.sc random
//
//  Created by Никита Сорочинский on 8/5/25.
//

import UIKit

protocol IClipboardManager {
    func copyTappedURL(url: String?)
    func copyTappedImage(image: UIImage?)
}

final class ClipboardManager {
    
}

extension ClipboardManager: IClipboardManager {
    func copyTappedURL(url: String?) {
        guard let url = url else { return }
        if !url.isEmpty {
            UIPasteboard.general.string = url
        }
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
    }
    
    func copyTappedImage(image: UIImage?) {
        guard let image = image else { return }
        UIPasteboard.general.image = image
        
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.impactOccurred()
    }
}
