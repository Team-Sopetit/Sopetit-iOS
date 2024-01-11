//
//  StoryTellingViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/09.
//

import UIKit

final class StoryTellingViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let firstView = StoryTellingFirstView()
    private let secondView = StoryTellingSecondView()
    private let thirdView = StoryTellingThirdView()

    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = firstView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setAddTarget()
    }
}

// MARK: - Extensions

extension StoryTellingViewController {
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setAddTarget() {
        firstView.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        secondView.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        thirdView.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case firstView.nextButton:
            self.view = secondView
            self.viewWillLayoutSubviews()
        case secondView.nextButton:
            self.view = thirdView
            self.viewWillLayoutSubviews()
        case thirdView.nextButton:
            let nav = DollChoiceViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        default:
            break
        }
    }
}
