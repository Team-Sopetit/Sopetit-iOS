//
//  HomeViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/9/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let homeView = HomeView()
    private lazy var collectionView = homeView.actionCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        super.loadView()
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAPI()
        setUI()
        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions

extension HomeViewController {

    func setUI() {
        
    }
    
    func setHierarchy() {
        
    }
    
    func setLayout() {
        
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Network

extension HomeViewController {

    func getAPI() {
        
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ActionCollectionViewCell.dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        return cell
    }
}
