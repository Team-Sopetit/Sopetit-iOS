//
//  BottomSheetViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/07.
//

import UIKit

import SnapKit

protocol BottomSheetButtonDelegate: AnyObject {
    func leftButtonTapped()
    func rightButtonTapped()
}

final class BottomSheetViewController: UIViewController {
    
    // MARK: - Properties
    
    private var bottomType: BottomSheetType = .dailyCompleteBottom
    private var bottomHeight: CGFloat = SizeLiterals.Screen.screenHeight * 310 / 812
    
    weak var buttonDelegate: BottomSheetButtonDelegate?
    
    // MARK: - UI Components
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray700.withAlphaComponent(0.6)
        return view
    }()
    
    private let bottomSheet: UIView = {
        let view = UIView()
        view.backgroundColor = .SoftieWhite
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 20
        return view
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head1)
        label.textColor = .Gray700
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.body4)
        label.textColor = .Gray700
        return label
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Gray100
        button.setTitleColor(.Gray300, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.Gray000, for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Life Cycles
    
    init(bottomStyle: BottomSheetType) {
        self.bottomType = bottomStyle
        super.init(nibName: nil, bundle: nil)
        
        setHierarchy()
        setLayout()
        bottomSheetGuide(bottomType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setHierarchy()
        setLayout()
        setDelegate()
    }
}

// MARK: - Extensions
extension BottomSheetViewController {
    
    func bottomSheetGuide(_ type: BottomSheetType) {
        imageView.image = type.image
        titleLabel.text = type.title
        subTitleLabel.text = type.subTitle
        subTitleLabel.textColor = type.subColor
        leftButton.setTitle(type.leftTitle, for: .normal)
        rightButton.setTitle(type.rightTitle, for: .normal)
        rightButton.setBackgroundColor(type.rightColor, for: .normal)
        
        switch type {
        case .dailyCompleteBottom, .happyCompleteBottom:
            imageView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(46)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(68)
                $0.height.equalTo(68)
            }
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(30)
                $0.centerX.equalToSuperview()
            }
            subTitleLabel.isHidden = true
        case .happyDeleteBottom:
            imageView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(53)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(66)
                $0.height.equalTo(61)
            }
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(30)
                $0.centerX.equalToSuperview()
            }
        case .dailyDeleteBottom, .logoutBottom:
            imageView.snp.makeConstraints {
                $0.top.equalToSuperview().inset(40)
                $0.centerX.equalToSuperview()
                $0.width.equalTo(66)
                $0.height.equalTo(61)
            }
            titleLabel.snp.makeConstraints {
                $0.top.equalTo(imageView.snp.bottom).offset(19)
                $0.centerX.equalToSuperview()
            }
        }
    }

    func setHierarchy() {
        bottomSheet.addSubviews(imageView, titleLabel, subTitleLabel, leftButton, rightButton)
        view.addSubviews(backgroundView, bottomSheet)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(bottomHeight)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        leftButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-17)
            $0.leading.equalToSuperview().inset(21)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 162 / 375)
            $0.height.equalTo(58)
        }
        
        rightButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-17)
            $0.trailing.equalToSuperview().inset(21)
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 162 / 375)
            $0.height.equalTo(58)
        }
    }
    
    func setDelegate() {
        leftButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc
    func buttonTapped(_ sender: UIButton) {
        switch sender {
        case leftButton:
            self.dismiss(animated: false)
            buttonDelegate?.leftButtonTapped()
        case rightButton:
            buttonDelegate?.rightButtonTapped()
        default:
            break
        }
    }
}
