//
//  DailyRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/29/24.
//

import UIKit

final class DailyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    private var dailyRoutineEntity = DailyRoutineEntity(routines: [])
    private let maxCount = 3
    private var completeRoutineId: Int = 0
    private var selectedList: [Int] = []
    
    override var isEditing: Bool {
        didSet {
            switch isEditing {
            case true:
                setWillEditing()
            case false:
                setDidEditing()
            }
        }
    }
    var isFromAddDailyBottom: Bool = false
    
    // MARK: - UI Components
    
    private let dailyRoutineView = DailyRoutineView()
    private let dailyCompleteBottomSheet = BottomSheetViewController(bottomStyle: .dailyCompleteBottom)
    private let dailyDeleteBottomSheet = BottomSheetViewController(bottomStyle: .dailyDeleteBottom)
    private var deleteToastView = AlertMessageView(title: "")
    private var addToastView = AlertMessageView(title: I18N.DailyRoutine.addDailyBottomTitle)
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = dailyRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setDelegate()
        getDailyRoutine()
        setRegister()
        setupCustomNavigationBar()
        setAddTarget()
        setAddToastView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.isEditing = false
    }
}

// MARK: - Extensions

private extension DailyRoutineViewController {

    func setUI() {
        dailyCompleteBottomSheet.modalPresentationStyle = .overFullScreen
        dailyDeleteBottomSheet.modalPresentationStyle = .overFullScreen
        deleteToastView.isHidden = true
        addToastView.isHidden = true
    }
    
    func setLayout() {
        self.view.addSubviews(deleteToastView, addToastView)
        
        deleteToastView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(51)
        }
        
        addToastView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(51)
        }
    }
    
    func setDelegate() {
        dailyRoutineView.collectionView.delegate = self
        dailyRoutineView.collectionView.dataSource = self
        dailyCompleteBottomSheet.buttonDelegate = self
        dailyDeleteBottomSheet.buttonDelegate = self
    }
    
    func setRegister() {
        DailyRoutineCollectionViewCell.register(target: dailyRoutineView.collectionView)
        DailyRoutineEmptyView.register(target: dailyRoutineView.collectionView)
    }
    
    func setupCustomNavigationBar() {
        dailyRoutineView.navigationBar.cancelButtonAction = {
            self.dailyRoutineView.navigationBar.cancelButton.isHidden = true
            self.dailyRoutineView.navigationBar.editButton.isHidden = false
            self.dailyRoutineView.deleteButton.isHidden = true
            self.isEditing = false
        }
        
        dailyRoutineView.navigationBar.isEditButtonIncluded = true
        dailyRoutineView.navigationBar.editButtonAction = {
            if self.dailyRoutineEntity.routines.isEmpty {
                return
            } else {
                self.isEditing = true
            }
        }
    }
    
    func setAddTarget() {
        dailyRoutineView.deleteButton.addTarget(self, action: #selector(tapDeleteButton), for: .touchUpInside)
    }
    
    func updateDeleteCount() {
        dailyRoutineView.deleteButton.setTitle("\(selectedList.count)개 삭제", for: .normal)
        if selectedList.count == 0 {
            dailyRoutineView.deleteButtonStatus = false
        } else {
            dailyRoutineView.deleteButtonStatus = true
        }
    }
    
    @objc
    func tapDeleteButton() {
        self.present(dailyDeleteBottomSheet, animated: false)
    }
    
    func setWillEditing() {
        dailyRoutineView.collectionView.snp.updateConstraints {
            $0.bottom.equalTo(dailyRoutineView.safeAreaLayoutGuide).offset(SizeLiterals.Screen.screenHeight * -56 / 812 - 37)
        }
        
        dailyRoutineView.deleteButton.isHidden = false
        dailyRoutineView.navigationBar.cancelButton.isHidden = false
        dailyRoutineView.navigationBar.editButton.isHidden = true
        for i in 0 ..< self.dailyRoutineEntity.routines.count {
            if let cell = self.dailyRoutineView.collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? DailyRoutineCollectionViewCell {
                cell.isEditing = true
            }
        }
        
    }
    
    func setDidEditing() {
        dailyRoutineView.collectionView.snp.updateConstraints {
            $0.bottom.equalTo(dailyRoutineView.safeAreaLayoutGuide)
        }
        dailyRoutineView.deleteButton.isHidden = true
        dailyRoutineView.navigationBar.cancelButton.isHidden = true
        dailyRoutineView.navigationBar.editButton.isHidden = false
        for i in 0 ..< self.dailyRoutineEntity.routines.count {
            if let cell = self.dailyRoutineView.collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? DailyRoutineCollectionViewCell {
                cell.radioStatus = false
                cell.isEditing = false
            }
        }
        self.selectedList = []
    }
}

extension DailyRoutineViewController {
    
    func setAddToastView() {
        if isFromAddDailyBottom {
            addToastView.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.addToastView.alpha = 0.0
            }, completion: {_ in
                self.addToastView.isHidden = true
                self.addToastView.alpha = 1.0
            })
        }
    }
    
    func setDeleteToastView(count: Int) {
        self.deleteToastView.isHidden = false
        let title = "데일리 루틴을 \(count)개 삭제했어요"
        self.deleteToastView.titleLabel.text = title
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
            self.deleteToastView.alpha = 0.0
        }, completion: {_ in
            self.deleteToastView.isHidden = true
            self.deleteToastView.alpha = 1.0
        })
    }
}

extension DailyRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyRoutineEntity.routines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDataBind(model: dailyRoutineEntity.routines[indexPath.item], index: indexPath.item)
        cell.delegate = self
        cell.radioDelegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let size = dailyRoutineEntity.routines.count < maxCount ?  CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 136) : .zero
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView = DailyRoutineEmptyView.dequeueReusableFooterView(collectionView: collectionView, indexPath: indexPath)
            footerView.delegate = self
            return footerView
        }
        return UICollectionReusableView()
    }
}

extension DailyRoutineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label: UILabel = {
            let label = UILabel()
            label.text = dailyRoutineEntity.routines[indexPath.row].content
            label.font = .fontGuide(.body1)
            return label
        }()
        label.sizeThatFits(CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 19))
        let height = heightForView(text: label.text ?? "", font: label.font, width: SizeLiterals.Screen.screenWidth - 146) + 117
        return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: height)
    }
    
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.setTextWithLineHeight(text: label.text, lineHeight: 24)
        label.sizeToFit()
        return label.frame.height
    }
}

extension DailyRoutineViewController: ConfirmDelegate {
    
    func tapButton(index: Int) {
        completeRoutineId = dailyRoutineEntity.routines[index].routineID
        if let iconURL = URL(string: dailyRoutineEntity.routines[index].iconImageURL) {
            self.dailyCompleteBottomSheet.imageView.downloadedsvg(from: iconURL)
        }
        self.present(dailyCompleteBottomSheet, animated: false)
    }
}

extension DailyRoutineViewController: AddDailyRoutineDelegate {
    
    func addDaily() {
        if isEditing == false {
            let vc = AddDailyRoutineViewController()
            vc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension DailyRoutineViewController: RadioButtonDelegate {
    
    func selectRadioButton(index: Int) {
        selectedList.append(dailyRoutineEntity.routines[index].routineID)
        updateDeleteCount()
    }
    
    func unselectRadioButton(index: Int) {
        for i in 0 ..< selectedList.count {
            if dailyRoutineEntity.routines[index].routineID == selectedList[i] {
                selectedList.remove(at: i)
                break
            }
        }
        updateDeleteCount()
    }
}

extension DailyRoutineViewController: BottomSheetButtonDelegate {
    
    func completeButtonTapped() {
        patchRoutineAPI(routineId: completeRoutineId)
    }
    
    func deleteButtonTapped() {
        let routineList = selectedList
        self.isEditing = false
        self.deleteToastView.isHidden = false
        var routineIdList = ""
        for routine in routineList {
            if routineIdList.isEmpty {
                routineIdList = "\(routine)"
            } else {
                routineIdList = "\(routineIdList),\(routine)"
            }
        }
        self.deleteRoutineListAPI(routineIdList: routineIdList, count: routineList.count)
    }
    
    func addButtonTapped() {
        
    }
}

// MARK: - Network

extension DailyRoutineViewController {
    
    func getDailyRoutine() {
        DailyRoutineService.shared.getDailyRoutine { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DailyRoutineEntity> {
                    if let listData = data.data {
                        self.dailyRoutineEntity = listData
                    }
                    self.dailyRoutineView.collectionView.reloadData()
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func deleteRoutineListAPI(routineIdList: String, count: Int) {
        DailyRoutineService.shared.deleteRoutineListAPI(routineIdList: routineIdList) { networkResult in
            switch networkResult {
            case .success:
                self.setDeleteToastView(count: count)
                self.dailyDeleteBottomSheet.dismiss(animated: false)
                self.getDailyRoutine()
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func patchRoutineAPI(routineId: Int) {
        DailyRoutineService.shared.patchRoutineAPI(routineId: routineId) { networkResult in
            switch networkResult {
            case .success:
                self.dailyCompleteBottomSheet.dismiss(animated: false)
                let vc = CompleteDailyRoutineViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
                self.getDailyRoutine()
            case .requestErr, .serverErr:
                break
            default:
                break
            }
            
        }
    }
}
