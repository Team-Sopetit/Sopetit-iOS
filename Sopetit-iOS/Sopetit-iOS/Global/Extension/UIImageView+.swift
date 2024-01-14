//
//  UIImageView+.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/12.
//

import UIKit

import Kingfisher

extension UIImageView {
    func kfSetImage(url: String?) {
        guard let url = url else { return }
        if let url = URL(string: url) {
            kf.indicatorType = .activity
            kf.setImage(with: url,
                        placeholder: nil,
                        options: [.transition(.fade(1.0))],
                        progressBlock: nil)
        }
    }
}
