//
//  HomeViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/9/24.
//

import UIKit

import SnapKit
import Lottie

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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            homeView.lottieHello.removeFromSuperview()
            homeView.lottieHello = LottieAnimationView(name: "gray_eating_daily")
            homeView.addSubview(homeView.lottieHello)
            homeView.lottieHello.snp.makeConstraints {
                $0.width.equalTo(414)
                $0.height.equalTo(418)
                $0.center.equalToSuperview()
            }
            homeView.lottieHello.loopMode = .playOnce
            homeView.lottieHello.play()
        case 1:
            homeView.lottieHello.removeFromSuperview()
            homeView.lottieHello = LottieAnimationView(name: "gray_eating_happy")
            homeView.addSubview(homeView.lottieHello)
            homeView.lottieHello.snp.makeConstraints {
                $0.width.equalTo(414)
                $0.height.equalTo(418)
                $0.center.equalToSuperview()
            }
            homeView.lottieHello.loopMode = .playOnce
            homeView.lottieHello.play()
        default:
            break
        }
    }
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
