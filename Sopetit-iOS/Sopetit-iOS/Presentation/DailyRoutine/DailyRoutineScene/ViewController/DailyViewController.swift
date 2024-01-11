//
//  RoutineViewController.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit

import SnapKit

protocol PresentDelegate: AnyObject {
    func buttonTapped(in cell: UICollectionViewCell)
}

final class DailyViewController: UIViewController {
    
    // MARK: - Properties
    
    let dummy = DailyEntity.routineDummy()
    var status: Int = 0
    let deleteBottom = BottomSheetViewController(bottomStyle: .dailyDeleteBottom)
    
    override var isEditing: Bool {
        didSet {
            // isEditing 상태에 따라 셀들을 업데이트
            updateCellsForEditing()
        }
    }
    
    // MARK: - UI Components
    
    private let routineView = DailyView()
    private lazy var collectionview = routineView.collectionView
    private let customNavigationBar = CustomNavigationBarView()
    let exampleBottom = BottomSheetViewController(bottomStyle: .dailyCompleteBottom)
    
    func setupCustomNavigationBar() {
        customNavigationBar.isLeftTitleLabelIncluded = I18N.TabBar.daily
        customNavigationBar.isLeftTitleViewIncluded = true
        customNavigationBar.isBackButtonIncluded = false
        customNavigationBar.isCancelButtonIncluded = true
        customNavigationBar.cancelButton.isHidden = true
        customNavigationBar.cancelButtonAction = {
            self.customNavigationBar.cancelButton.isHidden = true
            self.customNavigationBar.editButton.isHidden = false
            self.deleteButton.isHidden = true
            self.isEditing.toggle()
            for cell in self.collectionview.visibleCells {
                if let dailyCell = cell as? DailyRoutineCollectionViewCell {
                    dailyCell.achieveButton.isUserInteractionEnabled = true
                }
            }
            for cell in self.collectionview.visibleCells {
                if let dailyCell = cell as? DailyRoutineCollectionViewCell {
                    dailyCell.checkBox.isSelected = false
                }
            }
            DailyRoutineCollectionViewCell.sharedVariable = 0
        }
        
        customNavigationBar.isEditButtonIncluded = true
        customNavigationBar.editButtonAction = {
            self.isEditing.toggle()
            self.deleteButton.isHidden = false
            self.customNavigationBar.cancelButton.isHidden = false
            self.customNavigationBar.editButton.isHidden = true
            for cell in self.collectionview.visibleCells {
                if let dailyCell = cell as? DailyRoutineCollectionViewCell {
                    dailyCell.achieveButton.isUserInteractionEnabled = false
                }
            }
        }

    }
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("0개 삭제", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.backgroundColor = .Gray200
        button.layer.cornerRadius = 12
        button.isHidden = true
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        return button
    }()
    @objc
    func deleteTapped() {
        self.present(deleteBottom, animated: false)
    }
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        setupCustomNavigationBar()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
        setAddTarget()

    }
}

// MARK: - Extensions

extension DailyViewController {

    func setUI() {
        self.view.backgroundColor = .SoftieBack
        exampleBottom.modalPresentationStyle = .overFullScreen
        deleteBottom.modalPresentationStyle = .overFullScreen
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setHierarchy() {
        self.view.addSubviews(customNavigationBar, deleteButton, routineView)
    }
    
    func setLayout() {
        
        customNavigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        routineView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(17)
            $0.height.equalTo(56)
        }
        
        self.view.bringSubviewToFront(deleteButton)
    }
    
    func setDelegate() {
        collectionview.delegate = self
        collectionview.dataSource = self
        exampleBottom.buttonDelegate = self
        deleteBottom.buttonDelegate = self
    }
    
    func setAddTarget() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateDeleteLabel), name: Notification.Name("SharedVariableDidChange"), object: nil)
    }
    
    private func updateCellsForEditing() {
        for cell in collectionview.visibleCells {
            if let dailyCell = cell as? DailyRoutineCollectionViewCell {
                dailyCell.checkBox.isHidden = !isEditing
            }
        }
    }
    
    @objc func updateDeleteLabel() {
        
        let count = DailyRoutineCollectionViewCell.sharedVariable
        let title = "\(count)개 삭제"
        deleteButton.setTitle(title, for: .normal)
        
        if DailyRoutineCollectionViewCell.sharedVariable == 0 {
            self.deleteButton.backgroundColor = .Gray200
            self.deleteButton.isUserInteractionEnabled = false
        } else {
            self.deleteButton.backgroundColor = .SoftieRed
            self.deleteButton.isUserInteractionEnabled = true
        }
        
    }
}

extension DailyViewController: UICollectionViewDelegate {
}

extension DailyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDatabind(model: dummy[indexPath.item])
        cell.delegate = self
        cell.tag = indexPath.item
        return cell
    }
    
    // Footer configuration
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = DailyFooterView.dequeueReusableFooterView(collectionView: collectionView, indexPath: indexPath)
            return footerView
        }
        return UICollectionReusableView()
    }
}

extension DailyViewController: BottomSheetButtonDelegate {
    func leftButtonTapped() {
        self.dismiss(animated: false)
    }
    
    func rightButtonTapped() {
        let cell = collectionview.cellForItem(at: [0, status]) as? DailyRoutineCollectionViewCell
        cell?.achieveButton.isEnabled = false
        self.dismiss(animated: false)
    }
}

extension DailyViewController: PresentDelegate {
    func buttonTapped(in cell: UICollectionViewCell) {
        self.status = cell.tag
        self.present(exampleBottom, animated: false)
    }
}
