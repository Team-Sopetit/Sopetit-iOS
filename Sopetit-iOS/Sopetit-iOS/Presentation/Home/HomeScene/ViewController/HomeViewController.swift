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
            if !(homeView.isAnimate) {
                self.homeView.isAnimate = true
                homeView.lottieEatingDaily.isHidden = false
                homeView.lottieHello.isHidden = true
                homeView.lottieEatingHappy.isHidden = true
                homeView.lottieEatingDaily.loopMode = .playOnce
                homeView.lottieEatingDaily.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    self.homeView.lottieEatingDaily.isHidden = true
                    self.homeView.lottieHello.isHidden = false
                    self.homeView.isAnimate = false
                }
            }
        case 1:
            if !(homeView.isAnimate) {
                self.homeView.isAnimate = true
                homeView.lottieEatingHappy.isHidden = false
                homeView.lottieHello.isHidden = true
                homeView.lottieEatingDaily.isHidden = true
                homeView.lottieEatingHappy.loopMode = .playOnce
                homeView.lottieEatingHappy.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    self.homeView.lottieEatingDaily.isHidden = true
                    self.homeView.lottieHello.isHidden = false
                    self.homeView.isAnimate = false
                }
            }
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
