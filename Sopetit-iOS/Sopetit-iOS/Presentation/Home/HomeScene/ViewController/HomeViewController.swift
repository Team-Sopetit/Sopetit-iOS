//
//  HomeViewController.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/9/24.
//

import UIKit

import SnapKit
import Lottie
import SafariServices

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    var homeEntity = HomeEntity(name: "", dollType: "", frameImageURL: "", dailyCottonCount: 0, happinessCottonCount: 0, conversations: [])
    var cottonDailyNum: Int = 0
    var cottonHappyyNum: Int = 0
    private var homeCottonEntity = HomeCottonEntity(cottonCount: 0)
    
    // MARK: - UI Components
    
    private var homeView = HomeView()
    private lazy var collectionView = homeView.actionCollectionView
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        sleep(1)
        getHomeAPI(socialAccessToken: UserManager.shared.getAccessToken)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        setAddTarget()
    }
}

// MARK: - Extensions

extension HomeViewController {
    
    func setUI() {
        print("⭐️⭐️⭐️")
        print(UserManager.shared.getAccessToken)
        homeView.setDoll(dollType: UserManager.shared.getDollType)
        self.navigationController?.navigationBar.isHidden = true
    }
    
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
        homeView.layoutIfNeeded()
    }
    
    func setAddTarget() {
        homeView.moneyButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        homeView.settingButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case homeView.moneyButton:
            if let url = URL(string: I18N.Home.moneyNotion) {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)
            }
        case homeView.settingButton:
            let nav = SettingViewController()
            self.navigationController?.pushViewController(nav, animated: true)
        default:
            break
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
                    self.cottonDailyNum = self.homeEntity.dailyCottonCount
                    self.cottonHappyyNum = self.homeEntity.happinessCottonCount
                    self.setDataBind(model: self.homeEntity)
                    self.collectionView.reloadData()
                    self.homeView.setNeedsDisplay()
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func patchCottonAPI(cottonType: String, indexPath: IndexPath) {
        HomeService.shared.patchCottonAPI(cottonType: cottonType) { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<HomeCottonEntity> {
                    if let listData = data.data {
                        self.homeCottonEntity = listData
                    }
                    DispatchQueue.main.async {
                        if let cell = self.collectionView.cellForItem(at: indexPath) as? ActionCollectionViewCell {
                            switch indexPath.item {
                            case 0:
                                self.cottonDailyNum = self.homeCottonEntity.cottonCount
                            case 1:
                                self.cottonHappyyNum = self.homeCottonEntity.cottonCount
                            default:
                                break
                            }
                            cell.numberLabel.text = "\(self.homeCottonEntity.cottonCount)개"
                            cell.setNeedsLayout()
                        }
                    }
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
                if self.cottonDailyNum > 0 {
                    self.homeView.isAnimate = true
                    patchCottonAPI(cottonType: "DAILY", indexPath: indexPath)
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
            }
        case 1:
            if !(homeView.isAnimate) {
                if self.cottonHappyyNum > 0 {
                    self.homeView.isAnimate = true
                    getHomeAPI(socialAccessToken: UserManager.shared.getAccessToken)
                    patchCottonAPI(cottonType: "HAPPINESS", indexPath: indexPath)
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
        cell.isUserInteractionEnabled = true
        cell.setDataBind(model: homeEntity)
        return cell
    }
}
