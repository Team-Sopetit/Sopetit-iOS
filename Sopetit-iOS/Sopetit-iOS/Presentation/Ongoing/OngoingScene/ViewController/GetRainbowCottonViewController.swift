//
//  GetRainbowCottonViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 8/29/24.
//

import UIKit

class GetRainbowCottonViewController: UIViewController {
    
    let getRainbowCottonView = GetRainbowCottonView()
    
    override func loadView() {
        self.view = getRainbowCottonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getRainbowCottonView.cottonLottieView.play()
        setAnimation()
    }
}

private extension GetRainbowCottonViewController {
    
    func setUI() {
        self.view.backgroundColor = .Gray1000
        self.view.isOpaque = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setAnimation() {
        self.getRainbowCottonView.toastImageView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            self.getRainbowCottonView.toastImageView.alpha = 1
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.dismiss(animated: false)
        }
    }
    
    func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCotton))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func tapCotton() {
        self.dismiss(animated: false)
    }
}
