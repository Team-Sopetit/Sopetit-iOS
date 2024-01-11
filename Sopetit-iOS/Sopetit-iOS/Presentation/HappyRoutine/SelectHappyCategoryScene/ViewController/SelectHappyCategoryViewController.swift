//
//  SelectHappyCategoryViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

final class SelectHappyCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tagList = HappyRoutineTag.dummy()
    private let categoryList = HappyRoutineCategory.dummy()
    
    private var selectedIndex = 0
    
    // MARK: - UI Components
    private let selectHappyCategoryView = SelectHappyCategoryView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = selectHappyCategoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Extensions

extension SelectHappyCategoryViewController {
    
    func setDelegate() {
        selectHappyCategoryView.tagview.collectionView.delegate = self
        selectHappyCategoryView.tagview.collectionView.dataSource = self
        selectHappyCategoryView.categoryCollectionView.delegate = self
        selectHappyCategoryView.categoryCollectionView.dataSource = self
    }
    
    func setRegister() {
        selectHappyCategoryView.tagview.collectionView.register(HappyRoutineTagCollectionViewCell.self, forCellWithReuseIdentifier: "HappyRoutineTagCollectionViewCell")
        selectHappyCategoryView.categoryCollectionView.register(HappyRoutineCategoryCollectionViewCell.self, forCellWithReuseIdentifier: "HappyRoutineCategoryCollectionViewCell")
    }
}

extension SelectHappyCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == selectHappyCategoryView.tagview.collectionView {
            return tagList.count
        } else if collectionView == selectHappyCategoryView.categoryCollectionView {
            return categoryList.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == selectHappyCategoryView.tagview.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HappyRoutineTagCollectionViewCell", for: indexPath) as? HappyRoutineTagCollectionViewCell else { return HappyRoutineTagCollectionViewCell() }
            
            if indexPath.row == selectedIndex {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                cell.isSelected = true
            }
            cell.bindText(text: tagList[indexPath.item])
            return cell
        } else if collectionView == selectHappyCategoryView.categoryCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HappyRoutineCategoryCollectionViewCell", for: indexPath) as? HappyRoutineCategoryCollectionViewCell else { return HappyRoutineCategoryCollectionViewCell() }
            cell.bindModel(model: categoryList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension SelectHappyCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == selectHappyCategoryView.tagview.collectionView {
            let label: UILabel = {
                let label = UILabel()
                label.font = .fontGuide(.body4)
                label.text = tagList[indexPath.item]
                label.sizeToFit()
                return label
            }()
            
            let width = label.intrinsicContentSize.width
            return CGSize(width: width + 14 * 2, height: 37)
        } else if collectionView == selectHappyCategoryView.categoryCollectionView {
            return CGSize(width: SizeLiterals.Screen.screenWidth - 40, height: 101)
        }
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == selectHappyCategoryView.tagview.collectionView {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            selectedIndex = indexPath.row
            print(selectedIndex)
        } else if collectionView == selectHappyCategoryView.categoryCollectionView {
            print(indexPath.row)
            let vc = AddHappyRoutineViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
