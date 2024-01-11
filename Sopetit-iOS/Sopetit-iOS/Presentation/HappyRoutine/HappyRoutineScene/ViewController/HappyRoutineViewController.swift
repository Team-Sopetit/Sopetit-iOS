//
//  HappyRoutineViewControllerViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

final class HappyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    private let happyRoutineData = HappyRoutineCard.dummy()
    
    // MARK: - UI Components
    
    private let happyRoutineView = HappyRoutineView()
    private let happyRoutineEmptyView = HappyRoutineEmptyView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = happyRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTapGesture()
        setUserCardData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Extensions

private extension HappyRoutineViewController {
    func setTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCardView(_:)))
        happyRoutineEmptyView.emptyHappyRoutineView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    func didTapCardView(_ sender: UITapGestureRecognizer) {
        let vc = SelectHappyCategoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUserCardData() {
        happyRoutineView.setDataBind(model: happyRoutineData)
    }
}
