//
//  RoutineViewController.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit
import SnapKit

final class DailyViewController: UIViewController {
    
    // MARK: - Properties
    
    let dummy = DailyEntity.routineDummy()
    
    // MARK: - UI Components
    private let routineView = DailyView()
    private lazy var collectionview = routineView.collectionView
    private let topView = DailyTopView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        
        // self.view = routineView
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
    }
    
    func setHierarchy() {
        self.view.addSubviews(topView, collectionview)
    }
    
    func setLayout() {
        topView.snp.makeConstraints() {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        collectionview.snp.makeConstraints() {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setDelegate() {
        collectionview.delegate = self
        collectionview.dataSource = self
    }
}

extension DailyViewController: UICollectionViewDelegate {
    
}

extension DailyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = DailyRoutineCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.setDatabind(model: dummy[indexPath.item])
        return cell
    }
}
