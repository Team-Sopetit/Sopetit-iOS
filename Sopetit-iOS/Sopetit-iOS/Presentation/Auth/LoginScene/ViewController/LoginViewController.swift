//
//  LoginViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/7/24.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - UI Components
    
    private let loginView = LoginView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        self.view = loginView
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

extension LoginViewController {

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

extension LoginViewController {

    func getAPI() {
        
    }
}
