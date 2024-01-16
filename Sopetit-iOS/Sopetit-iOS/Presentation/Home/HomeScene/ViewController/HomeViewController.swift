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
    
    var homeEntity = HomeEntity(name: "", dollType: "", frameImageURL: "", dailyCottonCount: 0, happinessCottonCount: 0, conversations: [])
    
    // MARK: - UI Components
    
    private var homeView = HomeView()
    private lazy var collectionView = homeView.actionCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        getHomeAPI(socialAccessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJtZW1iZXJJZCI6MywiaWF0IjoxNzA0OTQ5Mzg5LCJleHAiOjE3MDYxNTkzODl9.OnsKaJ9NagxGQx4i0T6_GFdIIn6ZtAph2XHD1zAsDtUbomVToXE3SSgsKvQi32yP8FaZxiCnKzRPn0I2Tb5bDw")
    }
}

// MARK: - Extensions

extension HomeViewController {
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setDataBind(model: HomeEntity) {
        homeView.setDataBind(model: model)
        let string = model.name
        let nameWidth = string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.bubble16)]).width
        homeView.dollNameLabel.snp.updateConstraints {
                $0.width.equalTo(nameWidth + 26)
        }
    }
}

// MARK: - Network

extension HomeViewController {
    
    func getHomeAPI(socialAccessToken: String) {
            HomeService.shared.getHomeAPI(socialAccessToken: socialAccessToken) { networkResult in
                switch networkResult {
                case .success(let data):
                    if let data = data as? GenericResponse<HomeEntity> {
                        if let listData = data.data {
                            self.homeEntity = listData
                        }
                        self.collectionView.reloadData()
                        self.setDataBind(model: self.homeEntity)
                        self.homeView.setDoll(dollType: self.homeEntity.dollType)
                        self.collectionView.reloadData()
                    }
                case .requestErr, .serverErr:
                    break
                default:
                    break
                }
            }
        }
}

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
                homeView.bubbleLabel.text = "냠냠~"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    self.homeView.lottieEatingDaily.isHidden = true
                    self.homeView.lottieHello.isHidden = false
                    self.homeView.isAnimate = false
                    self.homeView.refreshBubbleLabel()
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
                homeView.bubbleLabel.text = "냠냠~ 맛 개깔@롱지네"
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    self.homeView.lottieEatingDaily.isHidden = true
                    self.homeView.lottieHello.isHidden = false
                    self.homeView.isAnimate = false
                    self.homeView.refreshBubbleLabel()
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
        cell.setDataBind(model: homeEntity)
        return cell
    }
}
