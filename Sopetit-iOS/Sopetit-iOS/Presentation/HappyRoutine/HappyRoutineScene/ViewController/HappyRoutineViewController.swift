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
    
    private var happinessMemberEntity: HappinessMemberEntity? = nil
    var isFromAddHappyBottom: Bool = false
    
    override var isEditing: Bool {
        didSet {
            switch isEditing {
            case true:
                self.happyRoutineNavigationBar.cancelButton.isHidden = false
                self.happyRoutineNavigationBar.editButton.isHidden = true
                self.happyRoutineView.doneButton.setRedDeleteButton(title: I18N.HappyRoutine.deleteRoutine)
            case false:
                    self.happyRoutineNavigationBar.cancelButton.isHidden = true
                    self.happyRoutineNavigationBar.editButton.isHidden = false
                    self.happyRoutineView.doneButton.setNormalButton()
            }
        }
    }
    
    // MARK: - UI Components
    
    private let happyRoutineView = HappyRoutineView()
    private lazy var happyRoutineNavigationBar = happyRoutineView.navigationBar
    private let happyRoutineEmptyView = HappyRoutineEmptyView()
    private let happyCompleteBottom = BottomSheetViewController(bottomStyle: .happyCompleteBottom)
    private let happyDeleteBottom = BottomSheetViewController(bottomStyle: .happyDeleteBottom)
    
    // MARK: - Life Cycles
    
    override func loadView() {
        self.view = happyRoutineEmptyView
        self.happyRoutineEmptyView.emptyHappyRoutineView.fadeIn()
        self.happyRoutineEmptyView.bearDescriptionView.fadeIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTapGesture()
        setDelegate()
        setAddTarget()
        setAlertView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getHappinessMemberAPI()
        self.happyRoutineView.happyRoutineCardView.fadeIn()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
        setNavigationBar()
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
        if let happinessMemberEntity = self.happinessMemberEntity {
            happyRoutineView.setDataBind(model: happinessMemberEntity)
        }
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
            self.happyCompleteBottom.imageView.kfSetImage(url: self.happinessMemberEntity?.iconImageUrl)
            self.present(happyCompleteBottom, animated: false)
        case .red:
            self.present(happyDeleteBottom, animated: false)
        }
    }
    
    func setNavigationBar() {
        self.isEditing = false
        happyRoutineNavigationBar.cancelButton.isHidden = true
        happyRoutineNavigationBar.cancelButtonAction = {
            self.isEditing = false
        }
        
        happyRoutineNavigationBar.isEditButtonIncluded = true
        happyRoutineNavigationBar.editButtonAction = {
            self.isEditing = true
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
        guard let routineId = happinessMemberEntity?.routineId else { return }
        patchHappinessMemberRoutine(routineId: routineId)
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
        guard let routineId = happinessMemberEntity?.routineId else { return }
        deleteHappinessMemberRoutine(routineId: routineId)
        view = happyRoutineEmptyView
        happyRoutineEmptyView.fromRoutineView = true
        self.viewWillLayoutSubviews()
        self.dismiss(animated: false)
    }
    
    func addButtonTapped() { }
}

// MARK: - Network

private extension HappyRoutineViewController {
    
    func getHappinessMemberAPI() {
        HappyRoutineService.shared.getHappinessMemberAPI { networkResult in
            switch networkResult {
            case .success(let data):
                if let data = data as? GenericResponse<HappinessMemberEntity> {
                    if let listData = data.data {
                        self.happinessMemberEntity = listData
                    }
                    if self.happinessMemberEntity != nil {
                        self.view = self.happyRoutineView
                        self.view.layoutSubviews()
                        self.happyRoutineView.happyRoutineCardView.fadeIn()
                        self.setUserCardData()
                    }
                }
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func patchHappinessMemberRoutine(routineId: Int) {
        HappyRoutineService.shared.patchHappinessMemberRoutineAPI(routineId: routineId) { networkResult in
            switch networkResult {
            case .success(let data):
                print(data)
                self.happinessMemberEntity = nil
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
    
    func deleteHappinessMemberRoutine(routineId: Int) {
        HappyRoutineService.shared.deleteHappinessMemberRoutineAPI(routineId: routineId) { networkResult in
            switch networkResult {
            case .success(let data):
                print(data)
                self.happinessMemberEntity = nil
            case .requestErr, .serverErr:
                break
            default:
                break
            }
        }
    }
}
