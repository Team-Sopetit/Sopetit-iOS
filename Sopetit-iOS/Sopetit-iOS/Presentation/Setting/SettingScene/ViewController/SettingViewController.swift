//
//  SettingViewController.swift
//  Sopetit-iOS
//
//  Created by Woo Jye Lee on 1/12/24.
//

import UIKit

final class SettingViewController: UIViewController {
    
    // MARK: - Properties
    
    let sectionCellCounts = [3, 1, 1, 2]
    
    // MARK: - UI Components
    
    let customNaviBar = CustomNavigationBarView()
    let settingView = SettingView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setBarConfiguration()
    }
}

// MARK: - Extensions

extension SettingViewController {

    func setUI() {
        self.view.backgroundColor = .SoftieBack
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setHierarchy() {
        self.view.addSubviews(customNaviBar, settingView)
    }
    
    func setLayout() {
        customNaviBar.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        settingView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(customNaviBar.snp.bottom).offset(16)
        }
    }
    
    func setDelegate() {
        settingView.tableView.delegate = self
        settingView.tableView.dataSource = self
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCellCounts[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCellCounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        print(indexPath)
        return cell
    }
}

// MARK: - Network

extension SettingViewController {

    func getAPI() {
        
    }
}

extension SettingViewController {
    func setBarConfiguration() {
        customNaviBar.isBackButtonIncluded = true
        customNaviBar.isTitleViewIncluded = true
        customNaviBar.isTitleLabelIncluded = "설정"
    }
}
