//
//  CompleteHappyRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/14/24.
//

import UIKit

final class CompleteHappyRoutineViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let completeHappyRoutineView = CompleteHappyRoutineView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = completeHappyRoutineView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        completeHappyRoutineView.cottonLottieView.play()
        setAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
}

// MARK: - Extensions

private extension CompleteHappyRoutineViewController {
    
    func setAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
            self.completeHappyRoutineView.textLabel.alpha = 1
        })
        
        UIView.animate(withDuration: 0.5, delay: 1.0, animations: {
            self.completeHappyRoutineView.cottonLabel.alpha = 1
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.dismiss(animated: true)
        }
    }
}
