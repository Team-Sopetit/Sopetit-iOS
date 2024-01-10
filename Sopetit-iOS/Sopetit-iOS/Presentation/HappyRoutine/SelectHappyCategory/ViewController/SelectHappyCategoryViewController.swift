//
//  SelectHappyCategoryViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

final class SelectHappyCategoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tagList: [String] = [I18N.HappyRoutineCategory.all,
                             I18N.HappyRoutineCategory.relationship,
                             I18N.HappyRoutineCategory.aStep,
                             I18N.HappyRoutineCategory.rest,
                             I18N.HappyRoutineCategory.new,
                             I18N.HappyRoutineCategory.mind]
    
    private var selectedIndex = 0
    
    // MARK: - UI Components
    private let selectHappyCategoryView = SelectHappyCategoryView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        view = selectHappyCategoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Extensions

extension SelectHappyCategoryViewController {
    
    func setUI() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        selectHappyCategoryView.tagview.collectionView.delegate = self
        selectHappyCategoryView.tagview.collectionView.dataSource = self
    }
}

// MARK: - Network

extension SelectHappyCategoryViewController {
    
    func getAPI() {
        
    }
}

extension SelectHappyCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HappyRoutineTagCollectionViewCell", for: indexPath) as? HappyRoutineTagCollectionViewCell else { return HappyRoutineTagCollectionViewCell() }
        
        if indexPath.row == selectedIndex {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
            cell.isSelected = true
        }
        cell.bindText(text: tagList[indexPath.item])
        return cell
    }
}

extension SelectHappyCategoryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let label: UILabel = {
            let label = UILabel()
            label.font = .fontGuide(.body4)
            label.text = tagList[indexPath.item]
            label.sizeToFit()
            return label
        }()
        
        let size = label.intrinsicContentSize.width
        print(size)
        
        return CGSize(width: size + 14 * 2, height: 37)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        selectedIndex = indexPath.row
        print(selectedIndex)
    }
}
