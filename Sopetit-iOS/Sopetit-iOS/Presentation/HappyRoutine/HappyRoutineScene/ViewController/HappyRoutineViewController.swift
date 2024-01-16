//
//  HappyRoutineViewControllerViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

import SnapKit

final class HappyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    private let happyRoutineData = HappyRoutineCard.dummy()
    private var happinessMemberEntity: HappinessMemberEntity? = nil
    var isFromAddHappyBottom: Bool = false
    
    // MARK: - UI Components
    
    private let happyRoutineView = HappyRoutineView()
    private lazy var happyRoutineNavigationBar = happyRoutineView.navigationBar
    private let happyRoutineEmptyView = HappyRoutineEmptyView()
    private let happyCompleteBottom = BottomSheetViewController(bottomStyle: .happyCompleteBottom)
    private let happyDeleteBottom = BottomSheetViewController(bottomStyle: .happyDeleteBottom)
    private let completeHappyRoutineView = CompleteHappyRoutineView()
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = happyRoutineEmptyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setTapGesture()
        setUserCardData()
        setDelegate()
        setAddTarget()
        setNavigationBar()
        setAlertView()
        getHappinessMemberAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extensions

private extension HappyRoutineViewController {
    
    func setUI() {
        happyCompleteBottom.modalPresentationStyle = .overFullScreen
        happyDeleteBottom.modalPresentationStyle = .overFullScreen
    }
    
    func setTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCardView(_:)))
        happyRoutineEmptyView.emptyHappyRoutineView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc
    func didTapCardView(_ sender: UITapGestureRecognizer) {
        let vc = SelectHappyCategoryViewController()
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUserCardData() {
        happyRoutineView.setDataBind(model: happyRoutineData)
    }
    
    func setDelegate() {
        happyCompleteBottom.buttonDelegate = self
        happyDeleteBottom.buttonDelegate = self
    }
    
    func setAddTarget() {
        happyRoutineView.doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchUpInside)
    }
    
    @objc
    func tapDoneButton() {
        switch happyRoutineView.doneButton.type {
        case .normal:
            self.present(happyCompleteBottom, animated: false)
        case .red:
            self.present(happyDeleteBottom, animated: false)
        }
        
    }
    
    func setNavigationBar() {
        happyRoutineNavigationBar.cancelButton.isHidden = true
        happyRoutineNavigationBar.cancelButtonAction = {
            self.happyRoutineNavigationBar.cancelButton.isHidden = true
            self.happyRoutineNavigationBar.editButton.isHidden = false
            self.isEditing.toggle()
            self.happyRoutineView.doneButton.setNormalButton()
        }
        
        happyRoutineNavigationBar.isEditButtonIncluded = true
        happyRoutineNavigationBar.editButtonAction = {
            self.happyRoutineNavigationBar.cancelButton.isHidden = false
            self.happyRoutineNavigationBar.editButton.isHidden = true
            self.isEditing.toggle()
            self.happyRoutineView.doneButton.setRedDeleteButton(title: I18N.HappyRoutine.deleteRoutine)
        }
    }
    
    func setAlertView() {
        if isFromAddHappyBottom {
            happyRoutineView.addAlertView.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
                self.happyRoutineView.addAlertView.alpha = 0.0
            })
        }
    }
}

extension HappyRoutineViewController: BottomSheetButtonDelegate {
    
    func completeButtonTapped() {
        self.viewWillLayoutSubviews()
        self.dismiss(animated: false)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.view = self.happyRoutineEmptyView
        }
        let vc = CompleteHappyRoutineViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    func backButtonTapped() {
        self.happyRoutineNavigationBar.cancelButton.isHidden = true
        self.happyRoutineNavigationBar.editButton.isHidden = false
        self.dismiss(animated: false)
    }
    
    func deleteButtonTapped() {
        view = happyRoutineEmptyView
        happyRoutineEmptyView.fromRoutineView = true
        self.viewWillLayoutSubviews()
        self.dismiss(animated: false)
    }
    
    func addButtonTapped() {
        
    }
}

// MARK: - Network

private extension HappyRoutineViewController {
    
    func getHappinessMemberAPI() {
        HappyRoutineService.shared.getHappinessMemberAPI() { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<HappinessMemberEntity> {
                    print(data)
                    if let listData = data.data {
                        self.happinessMemberEntity = listData
                    }
                    if self.happinessMemberEntity != nil {
                        self.view = self.happyRoutineView
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
