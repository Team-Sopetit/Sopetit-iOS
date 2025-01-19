//
//  ChangeChallengeBSViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/16/24.
//


import UIKit

import SnapKit

protocol BottomSheetButtonDelegate: AnyObject {
    func changeButtonTapped()
}

final class ChangeChallengeBSViewController: UIViewController {
    
    // MARK: - Properties
    
    private var bottomHeight: CGFloat = 430
    var entity: ChangeRoutineBottomSheetEntity = ChangeRoutineBottomSheetEntity.changeBottomSheetInitial()
    weak var buttonDelegate: BottomSheetButtonDelegate?
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray1000
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
    
    private let changeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "챌린지를 변경할까요?"
        label.textColor = .Gray700
        label.font = .fontGuide(.head3)
        label.asLineHeight(.head3)
        return label
    }()
    
    private let changeSubTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 진행 중인 챌린지가 있어요"
        label.textColor = .Red200
        label.font = .fontGuide(.body2)
        label.asLineHeight(.body2)
        return label
    }()
    
    private let existChallengeCard = UIImageView()
    private let existChallengeIcon = UIImageView()
    
    private let existChallengeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.font = .fontGuide(.caption1)
        return label
    }()
    
    private let existChallengeContent: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.numberOfLines = 0
        return label
    }()
    
    private let arrowIcon = UIImageView(image: UIImage(resource: .icArrow))
    
    private let choiceChallengeCard = UIImageView()
    private let choiceChallengeIcon = UIImageView()
    
    private let choiceChallengeTitle: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.font = .fontGuide(.caption1)
        return label
    }()
    
    private let choiceChallengeContent: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.font = .fontGuide(.body2)
        label.numberOfLines = 0
        return label
    }()
    
    private let choiceLabel: UILabel = {
        let label = UILabel()
        label.text = "선택한 루틴"
        label.textColor = .SoftieWhite
        label.font = .fontGuide(.caption2)
        label.asLineHeight(.caption2)
        label.clipsToBounds = true
        label.backgroundColor = .Gray650
        label.layer.cornerRadius = 12
        label.textAlignment = .center
        return label
    }()
    
    let changeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Gray650
        button.setTitle("루틴 변경하기", for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.setBackgroundColor(.Gray650, for: .normal)
        button.setBackgroundColor(.Gray650, for: .selected)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI(model: entity)
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

// MARK: - Extensions
extension ChangeChallengeBSViewController {
    
    func bindUI(model: ChangeRoutineBottomSheetEntity) {
        existChallengeContent.text = model.existContent.replacingOccurrences(of: "\n", with: " ")
        choiceChallengeContent.text = model.choiceContent.replacingOccurrences(of: "\n", with: " ")
        [existChallengeContent, choiceChallengeContent].forEach {
            $0.asLineHeight(.body2)
        }
        existChallengeCard.layer.cornerRadius = 10
        choiceChallengeCard.layer.cornerRadius = 10
        (existChallengeTitle.text, existChallengeIcon.image, existChallengeCard.image) = setCardTitle(id: model.existThemeID)
        (choiceChallengeTitle.text, choiceChallengeIcon.image, choiceChallengeCard.image) = setCardTitle(id: model.choiceThemeID)
    }
    
    func setCardTitle(id: Int) -> (String, UIImage, UIImage) {
        return (ThemeDetailEntity.getTheme(id: id).themeTitle,
                ThemeDetailEntity.getTheme(id: id).themeImage,
                UIImage(named: "add_challenge\(id)") ?? UIImage())
    }
    
    func setHierarchy() {
        view.addSubviews(backgroundView,
                         bottomSheet)
        bottomSheet.addSubviews(changeTitleLabel,
                                          changeSubTitleLabel,
                                          existChallengeCard,
                                          arrowIcon,
                                          choiceChallengeCard,
                                          choiceLabel,
                                          changeButton)
        existChallengeCard.addSubviews(existChallengeIcon,
                                       existChallengeTitle,
                                       existChallengeContent)
        choiceChallengeCard.addSubviews(choiceChallengeIcon,
                                        choiceChallengeTitle,
                                        choiceChallengeContent)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(bottomHeight)
        }
        
        changeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
        changeSubTitleLabel.snp.makeConstraints {
            $0.top.equalTo(changeTitleLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        
        existChallengeCard.snp.makeConstraints {
            $0.top.equalTo(changeSubTitleLabel.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(92)
        }
        
        existChallengeIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(16)
        }
        
        existChallengeTitle.snp.makeConstraints {
            $0.centerY.equalTo(existChallengeIcon)
            $0.leading.equalTo(existChallengeIcon.snp.trailing).offset(2)
        }
        
        existChallengeContent.snp.makeConstraints {
            $0.top.equalTo(existChallengeTitle.snp.bottom).offset(6)
            $0.leading.equalTo(existChallengeIcon.snp.leading)
            $0.trailing.equalToSuperview().inset(35)
        }
        
        arrowIcon.snp.makeConstraints {
            $0.top.equalTo(existChallengeCard.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(18)
        }
        
        choiceChallengeCard.snp.makeConstraints {
            $0.top.equalTo(arrowIcon.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(92)
        }
        
        choiceChallengeIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(20)
            $0.size.equalTo(16)
        }
        
        choiceChallengeTitle.snp.makeConstraints {
            $0.centerY.equalTo(choiceChallengeIcon)
            $0.leading.equalTo(choiceChallengeIcon.snp.trailing).offset(2)
        }
        
        choiceChallengeContent.snp.makeConstraints {
            $0.top.equalTo(choiceChallengeTitle.snp.bottom).offset(6)
            $0.leading.equalTo(choiceChallengeIcon.snp.leading)
            $0.trailing.equalToSuperview().inset(35)
        }
        
        choiceLabel.snp.makeConstraints {
            $0.top.equalTo(choiceChallengeCard.snp.top).offset(-10)
            $0.trailing.equalTo(choiceChallengeCard.snp.trailing).offset(-4)
            $0.width.equalTo(62)
            $0.height.equalTo(24)
        }
        
        changeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(32)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(56)
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
        changeButton.addTarget(self, 
                               action: #selector(changeTapped),
                               for: .touchUpInside)
    }
    
    @objc
    func changeTapped() {
        buttonDelegate?.changeButtonTapped()
    }
}
