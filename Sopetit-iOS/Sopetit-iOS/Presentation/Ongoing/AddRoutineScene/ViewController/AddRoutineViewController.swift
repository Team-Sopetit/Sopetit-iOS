//
//  AddRoutineViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 5/27/24.
//

import UIKit

import SnapKit
import FirebaseAnalytics

final class AddRoutineViewController: UIViewController {
    
    // MARK: - UI Components
    
    private var addRoutineView = AddRoutineView()
    private lazy var routineCollectionView = addRoutineView.totalRoutineCollectionView
    private var routineEntity = ThemeSelectEntity(themes: [])
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = addRoutineView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setDelegate()
        getThemeAPI()
        setGesture()
    }
}

// MARK: - Extensions

extension AddRoutineViewController {
    
    func setUI() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setDelegate() {
        routineCollectionView.delegate = self
        routineCollectionView.dataSource = self
        addRoutineView.navigationView.delegate = self
    }
    
    func setGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapView)
        )
        self.addRoutineView.addCustomRoutineView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapView() {
        
    }
}

extension AddRoutineViewController: BackButtonProtocol {
    
    func tapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Network

extension AddRoutineViewController {
    
    func getThemeAPI() {
        OnBoardingService.shared.getOnboardingThemeAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<ThemeSelectEntity> {
                    if let listData = data.data {
                        self.routineEntity = listData
                    }
                    self.routineCollectionView.reloadData()
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.getThemeAPI()
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
}

extension AddRoutineViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let nav = AddRoutineDetailViewController()
        let routineTheme: Theme = routineEntity.themes[indexPath.item]
        nav.addRoutineInfoEntity = AddRoutineInfoEntity(id: routineTheme.themeID,
                                                        name: "",
                                                        img: "",
                                                        title: routineTheme.title,
                                                        description: routineTheme.description,
                                                        makerUrl: "")
        self.navigationController?.pushViewController(nav, animated: true)
    }
}

extension AddRoutineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SizeLiterals.Screen.screenWidth - 40,
                      height: 80)
    }
}

extension AddRoutineViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return routineEntity.themes.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TotalRoutineCollectionViewCell.dequeueReusableCell(collectionView: routineCollectionView, indexPath: indexPath)
        cell.setDataBind(model: routineEntity.themes[indexPath.item])
        return cell
    }
}
