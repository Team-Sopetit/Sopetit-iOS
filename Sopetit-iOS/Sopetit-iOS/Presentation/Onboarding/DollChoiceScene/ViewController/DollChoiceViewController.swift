//
//  DollChoiceViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/09.
//

import UIKit

final class DollChoiceViewController: UIViewController {
    
    // MARK: - Properties
    
    private let dollDownImage = [ImageLiterals.Onboarding.bearBrownDown, ImageLiterals.Onboarding.bearGrayDown, ImageLiterals.Onboarding.bearPandaDown, ImageLiterals.Onboarding.bearRedDown]
    private let dollUPImage = [ImageLiterals.Onboarding.bearBrownUp, ImageLiterals.Onboarding.bearGrayUp, ImageLiterals.Onboarding.bearPandaUp, ImageLiterals.Onboarding.bearRedUp]
    private var selectDollNum: Int = 0
    
    // MARK: - UI Components
    
    private let dollChoiceView = DollChoiceView()
    private lazy var collectionView = dollChoiceView.dollCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        view = dollChoiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
    }
}

// MARK: - Extensions

extension DollChoiceViewController {
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setAddTarget() {
        dollChoiceView.nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped() {
        let nav = DollNameViewController()
        nav.dollNum = selectDollNum
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension DollChoiceViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            collectionView.deselectItem(at: selectedIndexPath, animated: false)
            if let deselectedCell = collectionView.cellForItem(at: selectedIndexPath) as? DollChoiceCollectionViewCell {
                deselectedCell.setDataBind(image: dollDownImage[selectedIndexPath.item])
            }
        }
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? DollChoiceCollectionViewCell {
            selectedCell.setDataBind(image: dollUPImage[indexPath.item])
            selectDollNum = indexPath.item
        }
        dollChoiceView.nextButton.isEnabled = true
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let deselectedCell = collectionView.cellForItem(at: indexPath) as? DollChoiceCollectionViewCell {
            deselectedCell.setDataBind(image: dollDownImage[indexPath.item])
        }
        return true
    }
}

extension DollChoiceViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DollChoiceCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDataBind(image: dollDownImage[indexPath.item])
        cell.isSelected = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dollDownImage.count
    }
}
