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
    
    var status: Int = 0
    var isFromAddDailyBottom: Bool = false
    private var shouldShowFooterView: Bool = true
    var routineList: DailyRoutineEntity = .init(routines: [.init(routineID: 0, content: "", iconImageURL: "", achieveCount: 0, isAchieve: true)])
    
    override var isEditing: Bool {
        didSet {
            updateCellsForEditing()
        }
    }
    
    // MARK: - UI Components
    
    private let routineView = DailyView()
    private lazy var collectionview = routineView.collectionView
    private let dailyFooterView = DailyFooterView()
    private let customNavigationBar = CustomNavigationBarView()
    private let dailyCompleteBottom = BottomSheetViewController(bottomStyle: .dailyCompleteBottom)
    private let dailyDeleteBottom = BottomSheetViewController(bottomStyle: .dailyDeleteBottom)
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("0개 삭제", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.backgroundColor = .Gray200
        button.layer.cornerRadius = 12
        button.isHidden = true
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private var deleteAlertView = AlertMessageView(title: "")
    private var addAlertView = AlertMessageView(title: I18N.DailyRoutine.addDailyBottomTitle)
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRoutineListAPI()
        setHierarchy()
        setLayout()
        setUI()
        setDelegate()
        setAddTarget()
        setAlertView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCustomNavigationBar()
        self.tabBarController?.tabBar.isHidden = false
        
        self.deleteButton.isHidden = true
    }
}

// MARK: - Extensions

extension DailyViewController {
    
    func setUI() {
        self.view.backgroundColor = .SoftieBack
        dailyCompleteBottom.modalPresentationStyle = .overFullScreen
        dailyDeleteBottom.modalPresentationStyle = .overFullScreen
        self.navigationController?.navigationBar.isHidden = true
        self.view.bringSubviewToFront(deleteButton)
        deleteAlertView.isHidden = true
        addAlertView.isHidden = true
    }
    
    func setHierarchy() {
        self.view.addSubviews(customNavigationBar, deleteButton, routineView, deleteAlertView, addAlertView)
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
        
        deleteAlertView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(51)
        }
        
        addAlertView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(51)
        }
    }
    
    func setDelegate() {
        collectionview.delegate = self
        collectionview.dataSource = self
        dailyCompleteBottom.buttonDelegate = self
        dailyDeleteBottom.buttonDelegate = self
    }
    
    func setAddTarget() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateDeleteLabel), name: Notification.Name("SharedVariableDidChange"), object: nil)
        self.deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    @objc
    func deleteTapped() {
        self.present(dailyDeleteBottom, animated: false)
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
    
    func setAlertView() {
        if isFromAddDailyBottom {
            addAlertView.isHidden = false
            UIView.animate(withDuration: 2.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.addAlertView.alpha = 0.0
            })
        }
    }
}

extension DailyViewController: DailyAddDelegate {
    func addTapped() {
        let nav = AddDailyRoutineViewController()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension DailyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return shouldShowFooterView ? CGSize(width: collectionView.bounds.width, height: 136) : CGSize.zero
    }
}

extension DailyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = routineList.routines.count
        shouldShowFooterView = numberOfItems < 3
        setLayout()
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        let routine = routineList.routines[indexPath.item]
        cell.setDatabind(model: routine)
        cell.delegate = self
        cell.tag = routine.routineID
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = DailyFooterView.dequeueReusableFooterView(collectionView: collectionView, indexPath: indexPath)
            footerView.addDelegate = self
            if shouldShowFooterView == false {
                footerView.isHidden = true
            } else {
                footerView.isHidden = false
            }
            return footerView
        }
        return UICollectionReusableView()
    }
}

extension DailyViewController: BottomSheetButtonDelegate {
    
    func completeButtonTapped() {
        let cell = collectionview.cellForItem(at: [0, status]) as? DailyRoutineCollectionViewCell
        cell?.achieveButton.isEnabled = false
        self.dismiss(animated: false)
        let vc = CompleteDailyRoutineViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func deleteButtonTapped() {
        self.isEditing.toggle()
        self.deleteButton.isHidden = true
        customNavigationBar.cancelButton.isHidden = true
        customNavigationBar.editButton.isHidden = false
        for cell in self.collectionview.visibleCells {
            if let dailyCell = cell as? DailyRoutineCollectionViewCell {
                dailyCell.achieveButton.isUserInteractionEnabled = true
            }
        }
        self.deleteAlertView.isHidden = false
        
        for cell in self.collectionview.visibleCells {
            if let dailyCell = cell as? DailyRoutineCollectionViewCell {
                if dailyCell.checkBox.isSelected {
                    routineList.routines = routineList.routines.filter { $0.routineID != dailyCell.tag }
                    deleteRoutineListAPI(routineId: dailyCell.tag)
                }
            }
            self.collectionview.reloadData()
        }
        
        let count = DailyRoutineCollectionViewCell.sharedVariable
        let title = "데일리 루틴을 \(count)개 삭제했어요"
        deleteAlertView.titleLabel.text = title
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
            self.deleteAlertView.alpha = 0.0
        })
        
        self.dismiss(animated: false)
    }
    
    func addButtonTapped() {
        shouldShowFooterView.toggle()
        setLayout()
    }
}

extension DailyViewController: PresentDelegate {
    func buttonTapped(in cell: UICollectionViewCell) {
        self.status = cell.tag
        self.present(dailyCompleteBottom, animated: false)
    }
}

extension DailyViewController {
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
}

// MARK: - Network

extension DailyViewController {
    func getRoutineListAPI() {
        DailyRoutineService.shared.getRoutineListAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyRoutineEntity> {
                    if let listData = data.data {
                        self.routineList = listData
                    }
                    self.collectionview.reloadData()
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}

extension DailyViewController {
    func deleteRoutineListAPI(routineId: Int) {
        DailyRoutineService.shared.deleteRoutineListAPI(routineId: routineId) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyRoutineEntity> {
                    self.collectionview.reloadData()
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}

//extension DailyViewController {
//    func patchRoutineAPI(routineId: Int) {
//        DailyRoutineService.shared.patchRoutineAPI(routineId: routineId) { _ in
//            for cell in self.collectionview.visibleCells {
//                if let dailyCell = cell as? DailyRoutineCollectionViewCell {
//                    if dailyCell.checkBox.isSelected {
//                        self.routineList.routines = self.routineList.routines.filter { $0.routineID != dailyCell.tag }
//                    }
//                    if dailyCell.tag == routineId {
//                        dailyCell.
//                    }
//                }
//                self.collectionview.reloadData()
//            }
//        }
//    }
//}

// MARK: - Extension

extension DailyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = DailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)

        let data = routineList.routines[indexPath.item].content
        cell.routineLabel.text = data
        cell.routineLabel.preferredMaxLayoutWidth = collectionView.bounds.width - 164
        cell.layoutIfNeeded()

        let cellHeight = cell.routineLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let itemSizeWidth = collectionView.bounds.width - 40
        let itemSizeHeight = cellHeight + 126

        return CGSize(width: itemSizeWidth, height: itemSizeHeight)
    }
}
