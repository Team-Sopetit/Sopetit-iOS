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
    private let logoutBottom = BottomSheetViewController(bottomStyle: .logoutBottom)
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        logoutBottom.modalPresentationStyle = .overFullScreen
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
        logoutBottom.buttonDelegate = self
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath {
        case [3, 0]:
            presentLogoutBottom()
        case [3, 1]:
            pushDropoutView()
        default:
            break
        }
    }

    private func presentLogoutBottom() {
        present(logoutBottom, animated: true, completion: nil)
    }
    
    private func pushDropoutView() {
        self.navigationController?.pushViewController(WithdrawViewController(), animated: true)
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
        switch indexPath[0] {
        case 2...3:
            cell.nextButton.isHidden = true
        default:
            break
        }
        switch indexPath {
        case [0, 0]:
            cell.iconImage.image = ImageLiterals.Setting.icUserSecurity
            cell.settingLabel.text = "개인정보 처리방침"
        case [0, 1]:
            cell.iconImage.image = ImageLiterals.Setting.icDocument
            cell.settingLabel.text = "서비스 이용 약관"
        case [0, 2]:
            cell.iconImage.image = ImageLiterals.Setting.icGuide
            cell.settingLabel.text = "서비스 이용 가이드"
        case [1, 0]:
            cell.iconImage.image = ImageLiterals.Setting.icFeedback
            cell.settingLabel.text = "피드백"
        case [2, 0]:
            cell.settingLabel.text = "현재 버전 1.0.0"
            cell.settingLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(20)
                $0.centerY.equalToSuperview()
            }
        case [3, 0]:
            cell.settingLabel.text = "로그아웃"
            cell.settingLabel.textColor = .Gray300
            cell.settingLabel.font = .fontGuide(.body4)
            cell.settingLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(20)
                $0.centerY.equalToSuperview()
            }
        case [3, 1]:
            cell.settingLabel.text = "회원 탈퇴"
            cell.settingLabel.textColor = .Gray300
            cell.settingLabel.setUnderlinePartFontChange(targetString: "회원 탈퇴", font: .fontGuide(.body4))
            cell.settingLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(20)
                $0.centerY.equalToSuperview()
            }
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let separatorView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 8))
        separatorView.backgroundColor = .SoftieBack
        return separatorView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

extension SettingViewController {
    func setBarConfiguration() {
        customNaviBar.isBackButtonIncluded = true
        customNaviBar.isTitleViewIncluded = true
        customNaviBar.isTitleLabelIncluded = "설정"
    }
}

extension SettingViewController: BottomSheetButtonDelegate {
    func deleteButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func bakcButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func completeButtonTapped() {
        self.dismiss(animated: true)
    }
    
}
