//
//  UIImageView+.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/12.
//

import UIKit

import Kingfisher
import SVGKit

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
//    
//    func downloadedsvg(from url: URL, contentMode mode: UIImageView.ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let receivedicon: SVGKImage = SVGKImage(data: data),
//                let image = receivedicon.uiImage
//            else { return }
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }.resume()
//    }
    func downloadedsvg(from url: URL, contentMode mode: UIImageView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        DispatchQueue.global().async {
            let image = SVGKImage(contentsOf: url)
            DispatchQueue.main.async {
                self.image = image?.uiImage
            }
        }
//        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
//            //여기가 이제 이미지 로딩이 완료 된 이후
//            guard let self else {return}
//            switch result {
//            case .success(let image):
//                let receivedicon: SVGKImage = SVGKImage(data: image.image.pngData()!)
//                self.image = receivedicon.uiImage
//            case .failure(let error):
//                print(error.errorDescription)
//                return
//            }
//        }
    }
    
}
