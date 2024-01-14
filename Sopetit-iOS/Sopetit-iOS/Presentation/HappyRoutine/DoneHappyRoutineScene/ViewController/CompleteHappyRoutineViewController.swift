//
//  CompleteHappyRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/14/24.
//

import UIKit

final class CompleteHappyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private let completeHappyRoutineView = CompleteHappyRoutineView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = completeHappyRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension CompleteHappyRoutineViewController {

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

extension CompleteHappyRoutineViewController {

    func getAPI() {
        
    }
}
