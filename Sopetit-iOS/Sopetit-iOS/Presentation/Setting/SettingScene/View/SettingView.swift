//
//  SettingView.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/12/24.
//

import UIKit

import SnapKit

final class SettingView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Components
    
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .SoftieBack
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension SettingView {

    func setUI() {
        self.backgroundColor = .SoftieWhite
    }
    
    func setHierarchy() {
        self.addSubviews(tableView)
    }
    
    func setLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setAddTarget() {

    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        SettingTableViewCell.register(target: tableView)
    }
    
    func setDataBind() {
        
    }
}
