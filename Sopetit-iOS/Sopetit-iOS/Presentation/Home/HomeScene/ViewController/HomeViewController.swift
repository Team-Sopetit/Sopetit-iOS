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
import FirebaseAnalytics

final class HomeViewController: UIViewController {
    
    enum AnimationKeyFrames: CGFloat {
        case start = 0
        case eatDaily = 21
        case eatHappy = 45
        case end = 68
    }
    
    // MARK: - Properties
    
    var homeEntity = HomeEntity(name: "", dollType: "", dailyCottonCount: 0, happinessCottonCount: 0, conversations: [])
    var cottonDailyNum: Int = 0
    var cottonHappyyNum: Int = 0
    private var homeCottonEntity = HomeCottonEntity(cottonCount: 0)
    private var isSelectionEnabled: Bool = true
    
    // MARK: - UI Components
    
    private var homeView = HomeView()
    private lazy var collectionView = homeView.actionCollectionView
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = homeView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        showTutorial()
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
    
    func showTutorial() {
        startLoadingIndicator()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.getHomeAPI(socialAccessToken: UserManager.shared.getAccessToken)
            if !UserManager.shared.isShowTutorial {
                let nav = TutorialViewController()
                nav.modalPresentationStyle = .overFullScreen
                self.present(nav, animated: false)
            }
        }
    }
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setDataBind(model: HomeEntity) {
        homeView.setDataBind(model: model)
        UserManager.shared.updateDollName(model.name)
        let string = model.name
        let nameWidth = string.size(withAttributes: [NSAttributedString.Key.font: UIFont.fontGuide(.bubble2)]).width
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
                self.present(safariViewController, animated: true, completion: nil)
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
                    self.homeView.bubbleLabelList = self.homeEntity.conversations
                    self.cottonDailyNum = self.homeEntity.dailyCottonCount
                    self.cottonHappyyNum = self.homeEntity.happinessCottonCount
                    self.setDataBind(model: self.homeEntity)
                    self.collectionView.reloadData()
                    self.homeView.setNeedsDisplay()
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.getHomeAPI(socialAccessToken: UserManager.shared.getAccessToken)
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
            DispatchQueue.main.async {
                self.stopLoadingIndicator()
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
                    if let cell = self.collectionView.cellForItem(at: indexPath) as? ActionCollectionViewCell {
                        switch indexPath.item {
                        case 0:
                            self.cottonDailyNum = self.homeCottonEntity.cottonCount
                            cell.numberLabel.text = "\(self.cottonDailyNum)개"
                        case 1:
                            self.cottonHappyyNum = self.homeCottonEntity.cottonCount
                            cell.numberLabel.text = "\(self.cottonHappyyNum)개"
                        default:
                            break
                        }
                        cell.setNeedsLayout()
                    }
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.patchCottonAPI(cottonType: cottonType, indexPath: indexPath)
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    private func startLoadingIndicator() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        self.isSelectionEnabled = false
    }
    
    private func stopLoadingIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        self.isSelectionEnabled = true
    }
}

// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isSelectionEnabled else {
            return
        }
        
        switch indexPath.item {
        case 0:
            if !(homeView.isAnimate) {
                patchCottonAPI(cottonType: "DAILY", indexPath: indexPath)
                Analytics.logEvent("give_cottonball", parameters: ["kind": "daily"])
                if self.cottonDailyNum > 0 {
                    self.homeView.isAnimate = true
                    homeView.animationView.play(fromFrame: AnimationKeyFrames.eatDaily.rawValue,
                                                toFrame: AnimationKeyFrames.eatHappy.rawValue,
                                                loopMode: .playOnce)
                    homeView.bubbleLabel.text = I18N.Home.cottonTitle
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                        self.homeView.isAnimate = false
                        self.homeView.refreshBubbleLabel()
                    }
                }
            }
        case 1:
            if !(homeView.isAnimate) {
                patchCottonAPI(cottonType: "HAPPINESS", indexPath: indexPath)
                Analytics.logEvent("give_cottonball", parameters: ["kind": "rainbow"])
                if self.cottonHappyyNum > 0 {
                    self.homeView.isAnimate = true
                    homeView.animationView.play(fromFrame: AnimationKeyFrames.eatHappy.rawValue,
                                                toFrame: AnimationKeyFrames.end.rawValue,
                                                loopMode: .playOnce)
                    homeView.bubbleLabel.text = I18N.Home.cottonTitle
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
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
