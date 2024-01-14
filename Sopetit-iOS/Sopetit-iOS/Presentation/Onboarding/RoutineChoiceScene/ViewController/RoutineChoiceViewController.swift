//
//  RoutineChoiceViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import UIKit

final class RoutineChoiceViewController: UIViewController {
    
    // MARK: - Properties
    
    private var selectedCount: Int = 0
    private var selectedRoutine: [Int] = []
    private let routineDummy = RoutineChoiceEntity.routineDummy()
    
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
            let nav = TabBarController()
            self.navigationController?.pushViewController(nav, animated: true)
        default:
            break
        }
    }
}

extension RoutineChoiceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? RoutineChoiceCollectionViewCell {
            if !selectedCell.isSelected {
                if selectedCount < 3 {
                    selectedCount += 1
                    selectedRoutine.append(routineDummy.themes[indexPath.item].routineID)
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
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        if let selectedCell = collectionView.cellForItem(at: indexPath) as? RoutineChoiceCollectionViewCell {
            if selectedCell.isSelected {
                if let index = selectedRoutine.firstIndex(where: { num in num == routineDummy.themes[indexPath.item].routineID }) {
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
            return true
        }
        return true
    }
}

extension RoutineChoiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = routineDummy.themes[indexPath.item].content
        let cellSize = CGSize(width: string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.body2)]).width + 40, height: string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.body2)]).height + 28)
        return cellSize
    }
}

extension RoutineChoiceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RoutineChoiceCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        let isSelected = selectedRoutine.contains(routineDummy.themes[indexPath.item].routineID)
        cell.setCellSelected(selected: isSelected)
        cell.setDataBind(model: routineDummy.themes[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routineDummy.themes.count
    }
}
