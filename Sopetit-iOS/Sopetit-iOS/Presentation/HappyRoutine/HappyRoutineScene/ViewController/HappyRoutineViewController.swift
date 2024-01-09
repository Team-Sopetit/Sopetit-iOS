//
//  HappyRoutineViewControllerViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

final class HappyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    private let happyRoutineView = HappyRoutineView()
    
    // MARK: - UI Components
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = happyRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Extensions

extension HappyRoutineViewController {

    func setUI() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        
    }
}

// MARK: - Network

extension HappyRoutineViewController {

    func getAPI() {
        
    }
}
