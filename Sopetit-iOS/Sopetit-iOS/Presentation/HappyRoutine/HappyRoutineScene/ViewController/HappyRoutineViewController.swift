//
//  HappyRoutineViewControllerViewController.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

final class HappyRoutineViewController: UIViewController {
    
    // MARK: - Properties
    
    private let happyRoutineData = HappyRoutineCard.dummy()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        self.present(happyCompleteBottom, animated: false)
    }
    
    func setNavigationBar() {
        happyRoutineNavigationBar.cancelButton.isHidden = true
        happyRoutineNavigationBar.cancelButtonAction = {
            self.happyRoutineNavigationBar.cancelButton.isHidden = true
            self.happyRoutineNavigationBar.deleteButton.isHidden = false
            self.isEditing.toggle()
        }
        
        happyRoutineNavigationBar.isDeleteButtonIncluded = true
        happyRoutineNavigationBar.deleteButtonAction = {
            self.happyRoutineNavigationBar.cancelButton.isHidden = false
            self.happyRoutineNavigationBar.deleteButton.isHidden = true
            self.isEditing.toggle()
            self.present(self.happyDeleteBottom, animated: false)
        }
    }
}

extension HappyRoutineViewController: BottomSheetButtonDelegate {
    
    func bakcButtonTapped() {
        self.happyRoutineNavigationBar.cancelButton.isHidden = true
        self.happyRoutineNavigationBar.deleteButton.isHidden = false
        self.dismiss(animated: false)
    }
    
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
    
    func deleteButtonTapped() {
        view = happyRoutineEmptyView
        happyRoutineEmptyView.fromRoutineView = true
        self.viewWillLayoutSubviews()
        self.dismiss(animated: false)
    }
}
