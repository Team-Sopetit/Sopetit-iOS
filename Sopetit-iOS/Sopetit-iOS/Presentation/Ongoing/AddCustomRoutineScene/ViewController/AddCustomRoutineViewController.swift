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
    private lazy var collectionView = addCustomRoutineView.themeCollectionView
    var routineEntity = ThemeSelectEntity(themes: [])
    
    private var selectThemeId: Int = -1 {
       didSet { updateNextButtonState() }
     }
     private var currentText: String = "" {
       didSet { updateNextButtonState() }
     }

    
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
        addCustomRoutineView.onTextChanged = { [weak self] text in
            self?.currentText = text
        }
    }
    
    func setDelegate() {
        addCustomRoutineView.navigationView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setAddTarget() {
        addCustomRoutineView.textClearButton.addTarget(
            self,
            action: #selector(tapClearButton),
            for: .touchUpInside
        )
        addCustomRoutineView.alarmToggle.addTarget(
            self,
            action: #selector(switchChanged(_:)),
            for: .valueChanged
        )
        let swipeGesture = UISwipeGestureRecognizer(
            target: self,
            action: #selector(handleSwipeGesture)
        )
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func tapClearButton() {
        let textView = addCustomRoutineView.customRoutineTextView
        currentText = ""
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
    
    @objc func switchChanged(_ sender: UISwitch) {
        addCustomRoutineView.alarmDatePicker.isHidden = !sender.isOn
        
        UIView.animate(withDuration: 0.25) {
            self.addCustomRoutineView.alarmStackView.layoutIfNeeded()
        }
    }
    
    @objc func handleSwipeGesture() {
        view.endEditing(true)
    }
    
    func updateNextButtonState() {
        let shouldEnable = (selectThemeId > 0) && !currentText.isEmpty
        addCustomRoutineView.navigationView.rightButton.isEnabled = shouldEnable
    }
}

extension AddCustomRoutineViewController: BackButtonProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddCustomRoutineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let string = routineEntity.themes[indexPath.item].title
        let cellSize = CGSize(width: string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.body2)]).width + 48, height: 36)
        return cellSize
    }
}

extension AddCustomRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return routineEntity.themes.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = ThemeSelectCollectionViewCell.dequeueReusableCell(
            collectionView: collectionView,
            indexPath: indexPath
        )
        cell.setDataBind(
            model: routineEntity.themes[indexPath.item],
            fromOnboarding: false
        )
        return cell
    }
}

extension AddCustomRoutineViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        makeVibrate()
        selectThemeId = routineEntity.themes[indexPath.item].themeID
        if let cell = collectionView.cellForItem(at: indexPath) as? ThemeSelectCollectionViewCell {
            cell.isSelected = true
            cell.backgroundColor = .Gray200
            cell.layer.borderColor = UIColor.Gray650.cgColor
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        selectThemeId = -1
        if let cell = collectionView.cellForItem(at: indexPath) as? ThemeSelectCollectionViewCell {
            cell.isSelected = false
            cell.backgroundColor = .SoftieWhite
            cell.layer.borderColor = UIColor.Gray200.cgColor
        }
    }
}
