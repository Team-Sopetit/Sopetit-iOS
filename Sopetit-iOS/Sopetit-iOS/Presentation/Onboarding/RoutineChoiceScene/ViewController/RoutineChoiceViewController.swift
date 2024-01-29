//
//  RoutineChoiceViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

final class RoutineChoiceViewController: UIViewController {
    
    // MARK: - Properties
    
    var selectedTheme: [Int] = []
    var userDollName: String = ""
    private var selectedCount: Int = 0
    private var selectedRoutine: [Int] = []
    private var routineEntity: [Routine] = []
    private var dollEntity = DollImageEntity(faceImageURL: "")
    
    // MARK: - UI Components
    
    private let routineChoiceView = RoutineChoiceView()
    private lazy var collectionView = routineChoiceView.collectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = routineChoiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
        getRoutineAPI()
        getDollAPI()
    }
}

// MARK: - Extensions

extension RoutineChoiceViewController {

    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setAddTarget() {
        routineChoiceView.backButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        routineChoiceView.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case routineChoiceView.backButton:
            self.navigationController?.popViewController(animated: true)
        case routineChoiceView.nextButton:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let keyWindow = windowScene.windows.first else {
                return
            }
            let nav = TabBarController()
            postMemberAPI()
            UserManager.shared.hasPostMember()
            keyWindow.rootViewController = UINavigationController(rootViewController: nav)
        default:
            break
        }
    }
}

// MARK: - Network

extension RoutineChoiceViewController {
    func getRoutineAPI() {
        for i in selectedTheme {
            OnBoardingService.shared.getOnboardingRoutineAPI(routineID: i) { networkResult in
                switch networkResult {
                case .success(let data):
                    if let data = data as? GenericResponse<RoutineChoiceEntity> {
                        dump(data)
                        if let listData = data.data {
                            self.routineEntity.append(contentsOf: listData.routines)
                        }
                    }
                    self.collectionView.reloadData()
                case .requestErr, .serverErr:
                    break
                default:
                    break
                }
            }
        }
    }
    
    func getDollAPI() {
        OnBoardingService.shared.getOnboardingDollAPI(dollType: UserManager.shared.getDollType) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DollImageEntity> {
                    if let listData = data.data {
                        self.dollEntity = listData
                    }
                    self.routineChoiceView.setDataBind(model: self.dollEntity)
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func postMemberAPI() {
        OnBoardingService.shared.postOnboardingMemeberAPI(dollType: UserManager.shared.getDollType, dollName: self.userDollName, routineArray: selectedRoutine) { networkResult in
            switch networkResult {
            case .success:
                print("success")
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}

extension RoutineChoiceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? RoutineChoiceCollectionViewCell {
            if !selectedCell.isSelected {
                if selectedCount < 3 {
                    selectedCount += 1
                    selectedRoutine.append(routineEntity[indexPath.item].routineID)
                    selectedCell.isSelected = true
                    selectedCell.routineLabel.backgroundColor = .Gray100
                    selectedCell.routineLabel.layer.borderColor = UIColor.Gray400.cgColor
                    selectedCell.routineLabel.layer.borderWidth = 2
                    routineChoiceView.infoLabel.isHidden = true
                    print(selectedRoutine)
                    makeVibrate()
                } else {
                    routineChoiceView.infoLabel.isHidden = false
                    return false
                }
            }
        }
        updateButton()
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? RoutineChoiceCollectionViewCell {
            if selectedCell.isSelected {
                if let index = selectedRoutine.firstIndex(where: { num in num == routineEntity[indexPath.item].routineID }) {
                    selectedRoutine.remove(at: index)
                }
                selectedCount -= 1
                if selectedCount <= 3 {
                    routineChoiceView.infoLabel.isHidden = true
                }
                selectedCell.isSelected = false
                selectedCell.routineLabel.backgroundColor = .SoftieWhite
                selectedCell.routineLabel.layer.borderColor = UIColor.Gray100.cgColor
                selectedCell.routineLabel.layer.borderWidth = 1
            }
            updateButton()
            return true
        }
        return true
    }
    
    func updateButton() {
        routineChoiceView.nextButton.isEnabled = selectedCount > 0
    }
}

extension RoutineChoiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = routineEntity[indexPath.item].content
        let cellSize = CGSize(width: string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.body2)]).width + 40, height: string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.body2)]).height + 28)
        return cellSize
    }
}

extension RoutineChoiceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RoutineChoiceCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        let isSelected = selectedRoutine.contains(routineEntity[indexPath.item].routineID)
        cell.setCellSelected(selected: isSelected)
        cell.setDataBind(model: routineEntity[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routineEntity.count
    }
}
