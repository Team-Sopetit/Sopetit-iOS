//
//  FeedbackAlertView.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 6/25/25.
//

import UIKit

import SnapKit

protocol FeedbackAlertDelegate: AnyObject {
    func backButtonTapped()
    func feedbackButtonTapped()
}

final class FeedbackAlertView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: FeedbackAlertDelegate?

    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "솜뭉치,모아두기만 하고\n안쓰고 있나요?"
        label.font = .fontGuide(.head3)
        label.textColor = .Gray700
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "여러분의 사용 습관을 듣고\n더 잘 쓰일 수 있도록 개선하려고 해요!"
        label.font = .fontGuide(.body2)
        label.textColor = .Gray500
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음에 할래요", for: .normal)
        button.setTitleColor(.Gray400, for: .normal)
        button.titleLabel?.font = .fontGuide(.head3)
        button.setBackgroundColor(.Gray100, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var feedbackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .imgFeedbackButton), for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setLayout()
        setAddTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension FeedbackAlertView {
    
    func setHierarchy() {
        alertView.addSubviews(
            titleLabel,
            subTitleLabel,
            cancelButton,
            feedbackButton
        )
        self.addSubviews(
            backgroundView,
            alertView
        )
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(SizeLiterals.Screen.screenHeight * 291 / 812)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 266 / 375)
            $0.height.equalTo(SizeLiterals.Screen.screenHeight * 175 / 812)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.bottom.equalTo(cancelButton.snp.top).offset(-16)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(11)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 118 / 375)
            $0.height.equalTo(49)
        }
        
        feedbackButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(11)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 118 / 375)
            $0.height.equalTo(49)
        }
    }
    
    func setAddTarget() {
        cancelButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        feedbackButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case cancelButton:
            delegate?.backButtonTapped()
        case feedbackButton:
            delegate?.feedbackButtonTapped()
        default:
            break
        }
    }
}
