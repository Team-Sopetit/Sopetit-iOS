//
//  RoutineViewController.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit
import SnapKit

protocol MyCellDelegate: AnyObject {
    func buttonTapped(in cell: UICollectionViewCell)
}

final class DailyViewController: UIViewController {
    
    // MARK: - Properties
    
    let dummy = DailyEntity.routineDummy()
    var status: Int = 0
    
    // MARK: - UI Components
    private let routineView = DailyView()
    private lazy var collectionview = routineView.collectionView
    private let topView = DailyTopView()
    let exampleBottom = BottomSheetViewController(bottomStyle: .dailyCompleteBottom)
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension DailyViewController {

    func setUI() {
        self.view.backgroundColor = .SoftieBack
        exampleBottom.modalPresentationStyle = .overFullScreen
    }
    
    func setHierarchy() {
        self.view.addSubviews(topView, collectionview)
    }
    
    func setLayout() {
        topView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        collectionview.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setDelegate() {
        collectionview.delegate = self
        collectionview.dataSource = self
        exampleBottom.buttonDelegate = self
    }
}

extension DailyViewController: UICollectionViewDelegate {
}

extension DailyViewController: UICollectionViewDataSource, MyCellDelegate {
    func buttonTapped(in cell: UICollectionViewCell) {
        self.status = cell.tag
        self.present(exampleBottom, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDatabind(model: dummy[indexPath.item])
        cell.delegate = self
//        print(indexPath)
        cell.tag = indexPath.item
        return cell
    }
}

extension DailyViewController: BottomSheetButtonDelegate {
    func leftButtonTapped() {
        self.dismiss(animated: false)
    }
    
    func rightButtonTapped() {
        let cell = collectionview.cellForItem(at: [0, status]) as? DailyRoutineCollectionViewCell
        cell?.achieveButton.isEnabled = false
        self.dismiss(animated: false)
    }
}
