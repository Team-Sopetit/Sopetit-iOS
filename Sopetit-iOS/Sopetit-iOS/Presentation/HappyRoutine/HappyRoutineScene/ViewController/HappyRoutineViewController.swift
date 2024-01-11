//
//  HappyRoutineViewControllerViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

final class HappyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    private let happyRoutineEmptyView = HappyRoutineEmptyView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = happyRoutineEmptyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Extensions

extension HappyRoutineViewController {
    func setTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCardView(_:)))
        happyRoutineEmptyView.emptyHappyRoutineView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    func didTapCardView(_ sender: UITapGestureRecognizer) {
        let vc = SelectHappyCategoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
