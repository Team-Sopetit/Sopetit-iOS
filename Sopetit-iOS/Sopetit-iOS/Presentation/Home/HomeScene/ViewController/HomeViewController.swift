//
//  HomeViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/9/24.
//

import UIKit

import SnapKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    let homeDummy: HomeEntity = HomeEntity.dummy()
    
    // MARK: - UI Components
    
    private let homeView = HomeView()
    private lazy var collectionView = homeView.actionCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setDataBind()
    }
}

// MARK: - Extensions

extension HomeViewController {
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setDataBind() {
        homeView.setDataBind(model: homeDummy)
        let string = homeDummy.name
        let nameWidth = string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.bubble16)]).width
        homeView.dollNameLabel.snp.updateConstraints {
                $0.width.equalTo(nameWidth + 26)
        }
    }
}

// MARK: - Network

extension HomeViewController {}


// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ActionCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.tag = indexPath.item
        cell.setDataBind(model: homeDummy)
        return cell
    }
}
