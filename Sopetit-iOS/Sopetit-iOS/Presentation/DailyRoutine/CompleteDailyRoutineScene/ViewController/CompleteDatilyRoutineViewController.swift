//
//  CompleteDatilyRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/15/24.
//

import UIKit

final class CompleteDatilyRoutineViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let completeDailyRoutineView = CompleteDailyRoutineView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = completeDailyRoutineView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        completeDailyRoutineView.cottonLottieView.play()
        setAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

// MARK: - Extensions

private extension CompleteDatilyRoutineViewController {
    
    func setAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            self.completeDailyRoutineView.textLabel.alpha = 1
        })
        
        UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
            self.completeDailyRoutineView.cottonLabel.alpha = 1
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.dismiss(animated: true)
        }
    }
}
