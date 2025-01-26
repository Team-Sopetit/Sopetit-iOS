//
//  EditMemoBSViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 12/3/24.
//

import UIKit

import SnapKit

final class EditMemoBSViewController: UIViewController {
    
    // MARK: - Properties
    
    private var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 280 / 812
    private var memoContent: String?
    private var memoId: Int?
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray950
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bottomSheet: UIView = {
        let view = UIView()
        view.backgroundColor = .SoftieWhite
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        return view
    }()
    
    private let memoContentLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body2)
        label.textColor = .Gray700
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    private let memoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.Gray300.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "메모"
        label.font = .fontGuide(.head4)
        label.textColor = .Gray700
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnMemoEdit), for: .normal)
        return button
    }()
    
    private let delButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .btnMemoDel), for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    init(memo: String, memoId: Int) {
        self.memoContent = memo
        self.memoId = memoId
        super.init(nibName: nil, bundle: nil)
        self.bindUI(memo: memo)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setHierarchy()
        setLayout()
        setDismissAction()
        setAddTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showBottomSheet()
    }
}

extension EditMemoBSViewController {
    
    func bindUI(memo: String) {
        memoContentLabel.text = memo
        memoContentLabel.asLineHeight(.body2)
        
        let backViewHeight = heightForView(text: memo, font: .fontGuide(.body2), width: SizeLiterals.Screen.screenWidth - 40) + 40.0
        bottomHeight = backViewHeight + 180
    }
    
    func setUI() {
        view.backgroundColor = .clear
    }
    
    func setHierarchy() {
        bottomSheet.addSubviews(titleLabel,
                                memoBackgroundView,
                                editButton,
                                delButton)
        view.addSubviews(backgroundView,
                         bottomSheet)
        memoBackgroundView.addSubview(memoContentLabel)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
        memoBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        memoContentLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(27)
        }
        
        editButton.snp.makeConstraints {
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.top.equalTo(memoBackgroundView.snp.bottom).offset(16)
            } else {
                $0.top.equalTo(memoBackgroundView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 32 / 812)
            }
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 47) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
        
        delButton.snp.makeConstraints {
            if SizeLiterals.Screen.deviceRatio > 0.5 {
                $0.top.equalTo(memoBackgroundView.snp.bottom).offset(16)
            } else {
                $0.top.equalTo(memoBackgroundView.snp.bottom).offset(SizeLiterals.Screen.screenHeight * 32 / 812)
            }
            $0.trailing.equalToSuperview().inset(21)
            $0.width.equalTo((SizeLiterals.Screen.screenWidth - 47) / 2)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 56 / 812)
        }
    }
    
    func showBottomSheet() {
        DispatchQueue.main.async {
            self.bottomSheet.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight - self.bottomHeight)
            }
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.backgroundView.backgroundColor = .Gray1000
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func hideBottomSheet() {
        DispatchQueue.main.async {
            self.bottomSheet.snp.remakeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
            }
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                self.backgroundView.backgroundColor = .clear
                self.view.layoutIfNeeded()
            }, completion: { _ in
                if self.presentingViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    func setDismissAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        backgroundView.addGestureRecognizer(tapGesture)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(hideBottomSheetAction))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc
    func hideBottomSheetAction() {
        hideBottomSheet()
    }
    
    func setAddTarget() {
        editButton.addTarget(self,
                             action: #selector(tapEditButton),
                             for: .touchUpInside)
        delButton.addTarget(self,
                            action: #selector(tapDelButton),
                            for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapEditButton))
        self.memoBackgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func tapEditButton() {
        let nav = AddMemoBSViewController(memo: self.memoContent ?? "",
                                          memoId: self.memoId ?? 0)
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: false)
    }
    
    @objc
    func tapDelButton() {
        delMemo()
    }
}

// MARK: - Networks

extension EditMemoBSViewController {
    
    func delMemo() {
        AchieveService.shared.deleteRoutineListAPI(memoId: self.memoId ?? 0) { networkResult in
            switch networkResult {
            case .success(let data):
                if let _ = data as? GenericResponse<EmptyEntity> {
                    NotificationCenter.default.post(name: Notification.Name("delMemo"), object: nil)
                    self.hideBottomSheet()
                }
            case .reissue:
                ReissueService.shared.postReissueAPI(refreshToken: UserManager.shared.getRefreshToken) { success in
                    if success {
                        self.delMemo()
                    } else {
                        self.makeSessionExpiredAlert()
                    }
                }
            case .requestErr, .serverErr:
                self.makeServerErrorAlert()
            default:
                break
            }
        }
    }
}
