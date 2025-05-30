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
        setAddTarget()
    }
}

extension AddCustomRoutineViewController {
    
    func setUI() {
        
    }
    
    func setDelegate() {
        addCustomRoutineView.navigationView.delegate = self
    }
    
    func setAddTarget() {
        addCustomRoutineView.textClearButton.addTarget(
            self,
            action: #selector(tapClearButton),
            for: .touchUpInside
        )
    }
    
    @objc func tapClearButton() {
        let textView = addCustomRoutineView.customRoutineTextView
        textView.text = ""
        textView.resignFirstResponder()
        textView.constraints.forEach { constraint in
            if constraint.firstAttribute == .height {
                constraint.constant = 52
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.addCustomRoutineView.layoutIfNeeded()
        }
    }
}

extension AddCustomRoutineViewController: BackButtonProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
