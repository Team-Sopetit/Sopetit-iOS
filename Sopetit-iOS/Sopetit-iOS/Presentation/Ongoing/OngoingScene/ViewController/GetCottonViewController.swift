//
//  GetCottonViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/25/24.
//

import UIKit

class GetCottonViewController: UIViewController {
    
    let getCottonView = GetCottonView()
    
    override func loadView() {
        self.view = getCottonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getCottonView.cottonLottieView.play()
        setAnimation()
    }
}

private extension GetCottonViewController {
    
    func setUI() {
        self.view.backgroundColor = .Gray1000
        self.view.isOpaque = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setAnimation() {
        self.getCottonView.toastImageView.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            self.getCottonView.toastImageView.alpha = 1
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
