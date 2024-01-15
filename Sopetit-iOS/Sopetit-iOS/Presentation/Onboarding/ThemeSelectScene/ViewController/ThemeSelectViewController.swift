//
//  ThemeSelectViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

final class ThemeSelectViewController: UIViewController {
    
    // MARK: - Properties
    
    private var themeEntity = ThemeSelectEntity(themes: [])
    private var dollEntity = DollImageEntity(faceImageURL: "")
    var selectedCount = 0
    var selectedCategory: [Int] = []
    var doll: String = ""
    var dollType: String = ""
    
    // MARK: - UI Components
    
    let themeSelectView = ThemeSelectView()
    private lazy var collectionView = themeSelectView.collectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = themeSelectView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
        getThemeAPI()
        getDollAPI()
    }
}

// MARK: - Extensions

extension ThemeSelectViewController {

    func setUI() {
        themeSelectView.bubbleLabel.text = "안녕 난 \(doll)야!\n나와 함께 루틴을 만들어볼까?"
        themeSelectView.bubbleLabel.partColorChange(targetString: doll, textColor: .SoftieBrown)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setAddTarget() {
        themeSelectView.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        let nav = RoutineChoiceViewController()
        nav.selectedTheme = selectedCategory
        nav.userDollName = doll
        nav.userDollType = dollType
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension ThemeSelectViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? ThemeSelectCollectionViewCell {
            if !selectedCell.isSelected {
                if selectedCount < 3 {
                    selectedCount += 1
                    selectedCategory.append(themeEntity.themes[indexPath.item].themeID)
                    selectedCell.isSelected = true
                    selectedCell.themeIcon.backgroundColor = .Gray100
                    selectedCell.themeIcon.layer.borderColor = UIColor.Gray400.cgColor
                    selectedCell.themeIcon.layer.borderWidth = 2
                    if selectedCount == 3 {
                        themeSelectView.nextButton.isEnabled = true
                        print(selectedCategory)
                    }
                } else {
                    return false
                }
            }
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? ThemeSelectCollectionViewCell {
            if selectedCell.isSelected {
                if let index = selectedCategory.firstIndex(where: { num in num == themeEntity.themes[indexPath.item].themeID }) {
                    selectedCategory.remove(at: index)
                }
                selectedCount -= 1
                selectedCell.isSelected = false
                selectedCell.themeIcon.backgroundColor = .SoftieWhite
                selectedCell.themeIcon.layer.borderColor = UIColor.Gray100.cgColor
                selectedCell.themeIcon.layer.borderWidth = 1
                themeSelectView.nextButton.isEnabled = false
            }
            return true
        }
        return true
    }
}

extension ThemeSelectViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ThemeSelectCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDataBind(model: themeEntity.themes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeEntity.themes.count
    }
}

// MARK: - Network

private extension ThemeSelectViewController {
    func getThemeAPI() {
        OnBoardingService.shared.getOnboardingThemeAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ThemeSelectEntity> {
                    if let listData = data.data {
                        self.themeEntity = listData
                    }
                    self.collectionView.reloadData()
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func getDollAPI() {
        OnBoardingService.shared.getOnboardingDollAPI(dollType: self.dollType) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<DollImageEntity> {
                    if let listData = data.data {
                        self.dollEntity = listData
                    }
                    self.themeSelectView.setDataBind(model: self.dollEntity)
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}
