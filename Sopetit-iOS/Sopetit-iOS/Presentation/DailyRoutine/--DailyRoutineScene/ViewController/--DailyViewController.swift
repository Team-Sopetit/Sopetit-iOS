//
//  RoutineViewController.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit

import SnapKit

protocol PresentDelegate: AnyObject {
    func buttonTapped(in cell: ExDailyRoutineCollectionViewCell)
}

final class ExDailyViewController: UIViewController {
    
    // MARK: - Properties
    
    var isFromAddDailyBottom: Bool = false
    private var shouldShowFooterView: Bool = true
    var routineList: DailyRoutineEntity = .init(routines: [])
    private var achieveIndex: Int = -1
    
    override var isEditing: Bool {
        didSet {
            updateCellsForEditing()
            updateRoutineViewLayout()

        }
    }
    
    // MARK: - UI Components
    
    private let routineView = ExDailyView()
    private lazy var collectionview = routineView.collectionView
    private let dailyFooterView = ExDailyFooterView()
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
        getRoutineListAPI()
        self.deleteButton.isHidden = true
    }
}

// MARK: - Extensions

extension ExDailyViewController {
    
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        deleteButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(17)
            $0.height.equalTo(56 * SizeLiterals.Screen.screenHeight / 812)
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
        self.deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    @objc
    func deleteTapped() {
        self.present(dailyDeleteBottom, animated: false)
    }
    
    private func updateCellsForEditing() {
        for cell in collectionview.visibleCells {
            if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                dailyCell.checkBox.isHidden = !isEditing
            }
        }
    }
    
    @objc func updateDeleteLabel() {
        let count = ExDailyRoutineCollectionViewCell.sharedVariable
        let title = "\(count)개 삭제"
        deleteButton.setTitle(title, for: .normal)
        
        if ExDailyRoutineCollectionViewCell.sharedVariable == 0 {
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

extension ExDailyViewController: DailyAddDelegate {
    
    func addTapped() {
        if self.dailyFooterView.isUserInteractionEnabled {
            let nav = AddDailyRoutineViewController()
            nav.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
}

extension ExDailyViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return shouldShowFooterView ? CGSize(width: collectionView.bounds.width, height: 136) : CGSize.zero
    }
}

extension ExDailyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = routineList.routines.count
        shouldShowFooterView = numberOfItems < 3
        setLayout()
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if routineList.routines.isEmpty {
            return UICollectionViewCell()
        } else {
            let cell = ExDailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
            let routine = routineList.routines[indexPath.item]
            cell.index = indexPath.item
            cell.setDatabind(model: routine)
            cell.delegate = self
            cell.tag = routine.routineID
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = ExDailyFooterView.dequeueReusableFooterView(collectionView: collectionView, indexPath: indexPath)
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

extension ExDailyViewController: BottomSheetButtonDelegate {
    
    func completeButtonTapped() {
        for cell in self.collectionview.visibleCells {
            if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                if dailyCell.index == achieveIndex {
                    patchRoutineAPI(routineId: dailyCell.tag)
                }
            }
        }
        self.dismiss(animated: false)
        let vc = CompleteDailyRoutineViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func deleteButtonTapped() {
        self.isEditing = false
        self.deleteButton.isHidden = true
        customNavigationBar.cancelButton.isHidden = true
        customNavigationBar.editButton.isHidden = false
        for cell in self.collectionview.visibleCells {
            if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                dailyCell.achieveButton.isUserInteractionEnabled = true
            }
        }
        self.deleteAlertView.isHidden = false
        
        var routineIdList = ""
        for cell in self.collectionview.visibleCells {
            if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                if dailyCell.checkBox.isSelected {
                    routineList.routines = routineList.routines.filter { $0.routineID != dailyCell.tag }
                    if routineIdList == "" {
                        routineIdList = "\(dailyCell.tag)"
                    } else {
                        routineIdList = "\(routineIdList),\(dailyCell.tag)"
                    }
                }
            }
        }
        
        self.deleteRoutineListAPI(routineIdList: routineIdList)
        let count = ExDailyRoutineCollectionViewCell.sharedVariable
        let title = "데일리 루틴을 \(count)개 삭제했어요"
        deleteAlertView.titleLabel.text = title
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
            self.deleteAlertView.alpha = 0.0
        })
        ExDailyRoutineCollectionViewCell.sharedVariable = 0
        NotificationCenter.default.removeObserver(self, name: Notification.Name("SharedVariableDidChange"), object: nil)
        
        self.dismiss(animated: false)
    }
    
    func addButtonTapped() {
        shouldShowFooterView.toggle()
        setLayout()
    }
}

extension ExDailyViewController: PresentDelegate {
    
    func buttonTapped(in cell: ExDailyRoutineCollectionViewCell) {
        if let iconURL = URL(string: routineList.routines[cell.index].iconImageURL) {
            self.dailyCompleteBottom.imageView.downloadedsvg(from: iconURL)
        }
        self.present(dailyCompleteBottom, animated: false)
        achieveIndex = cell.index
    }
}

extension ExDailyViewController {
    
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
            self.isEditing = false
            for cell in self.collectionview.visibleCells {
                if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                    dailyCell.achieveButton.isUserInteractionEnabled = true
                }
            }
            for cell in self.collectionview.visibleCells {
                if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                    dailyCell.checkBox.isSelected = false
                }
            }
            
            ExDailyRoutineCollectionViewCell.sharedVariable = 0
            
            NotificationCenter.default.removeObserver(self, name: Notification.Name("SharedVariableDidChange"), object: nil)
            
            self.dailyFooterView.isUserInteractionEnabled = true
        }
        
        customNavigationBar.isEditButtonIncluded = true
        customNavigationBar.editButtonAction = {
            if self.routineList.routines.isEmpty {
                return
            } else {
                ExDailyRoutineCollectionViewCell.sharedVariable = 0
                NotificationCenter.default.addObserver(self, selector: #selector(self.updateDeleteLabel), name: Notification.Name("SharedVariableDidChange"), object: nil)
                self.isEditing = true
                self.deleteButton.isHidden = false
                self.customNavigationBar.cancelButton.isHidden = false
                self.customNavigationBar.editButton.isHidden = true
                for cell in self.collectionview.visibleCells {
                    if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                        dailyCell.achieveButton.isUserInteractionEnabled = false
                    }
                }
            }
            
            self.dailyFooterView.isUserInteractionEnabled = false
        }
    }
    
    func updateRoutineViewLayout() {
        if self.isEditing == true {
            self.routineView.snp.updateConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide).offset((-56 * SizeLiterals.Screen.screenHeight / 812) - 20)
            }
        } else {
            self.routineView.snp.updateConstraints {
                $0.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }
}

extension ExDailyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if routineList.routines.isEmpty {
            return .zero
        }
        let cell = self.collectionView(collectionView, cellForItemAt: indexPath)
        return cell.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width - 40, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}

// MARK: - Network

extension ExDailyViewController {
    
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
    
    func deleteRoutineListAPI(routineIdList: String) {
        DailyRoutineService.shared.deleteRoutineListAPI(routineIdList: routineIdList) { networkResult in
            switch networkResult {
            case .success:
                self.dailyFooterView.isUserInteractionEnabled = true
                self.collectionview.reloadData()
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func patchRoutineAPI(routineId: Int) {
        DailyRoutineService.shared.patchRoutineAPI(routineId: routineId) { _ in
            for cell in self.collectionview.visibleCells {
                if let dailyCell = cell as? ExDailyRoutineCollectionViewCell {
                    if dailyCell.tag == routineId {
                        if let index = self.routineList.routines.firstIndex(where: { $0.routineID == routineId }) {
                            self.routineList.routines[index].isAchieve = true
                        }
                    }
                }
            }
            self.collectionview.reloadData()
        }
    }
}
