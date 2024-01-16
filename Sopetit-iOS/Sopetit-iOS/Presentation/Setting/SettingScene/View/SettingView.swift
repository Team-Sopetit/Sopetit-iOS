//
//  SettingView.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/12/24.
//

import UIKit

import SnapKit

final class SettingView: UIView {

    // MARK: - UI Components
    
    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero, style: .plain)
        tableview.backgroundColor = .SoftieWhite
        tableview.isScrollEnabled = false
        tableview.sectionFooterHeight = 0
        tableview.sectionHeaderTopPadding = 0
        tableview.separatorStyle = .none
        return tableview
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
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
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth)
        }
    }
    
    func setRegisterCell() {
        SettingTableViewCell.register(target: tableView)
    }
}
