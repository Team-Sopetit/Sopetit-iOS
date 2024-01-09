//
//  ThemeSelectViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

final class ThemeSelectViewController: UIViewController {
    
    // MARK: - Properties
    
    private let themeDummy = ThemeSelectEntity.themeDummy()
    var selectedCount = 0
    var selectedCategory: [Int] = []
    
    // MARK: - UI Components
    
    private let themeSelectView = ThemeSelectView()
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
    }
}

// MARK: - Extensions

extension ThemeSelectViewController {

    func setUI() {
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
        print("dd")
    }
}

extension ThemeSelectViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? ThemeSelectCollectionViewCell {
            if !selectedCell.isSelected {
                if selectedCount < 3 {
                    selectedCount += 1
                    selectedCategory.append(indexPath.item)
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
                if let index = selectedCategory.firstIndex(where: { num in num == indexPath.item }) {
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
        cell.setDataBind(model: themeDummy.themes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themeDummy.themes.count
    }
}
