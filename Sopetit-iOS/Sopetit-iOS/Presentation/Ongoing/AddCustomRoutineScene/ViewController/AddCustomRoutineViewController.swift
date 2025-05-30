//
//  AddCustomRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/30/25.
//
import UIKit

import SnapKit
import FirebaseAnalytics

final class AddCustomRoutineViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var addCustomRoutineView = AddCustomRoutineView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addCustomRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
    }
}

extension AddCustomRoutineViewController {
    
    func setUI() {
        
    }
    
    func setDelegate() {
        addCustomRoutineView.navigationView.delegate = self
    }
}

extension AddCustomRoutineViewController: BackButtonProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
