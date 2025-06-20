//
//  AddRoutinDetailBSViewController.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/16/24.
//

import UIKit

import SnapKit

final class AddRoutinDetailBSViewController: UIViewController {
    
    // MARK: - Properties
    
    private var bottomHeight: CGFloat = SizeLiterals.Screen.deviceRatio > 0.5 ? 456 : 412
    var entity: AddRoutineBottomSheetEntity = AddRoutineBottomSheetEntity.bottomSheetInitial()
    
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
    
    private let challengeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "챌린지"
        label.textColor = .Gray700
        label.font = .fontGuide(.head4)
        label.asLineHeight(.head4)
        return label
    }()
    
    private let contentBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .Gray200
        view.layer.borderColor = UIColor.Gray300.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let detailContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray700
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .fontGuide(.body1)
        return label
    }()
    
    private let detailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .fontGuide(.body2)
        return label
    }()
    
    private let detailTimeIcon = UIImageView(image: UIImage(resource: .icTime))
    private let detailTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.font = .fontGuide(.caption1)
        return label
    }()
    
    private let detailPlaceIcon = UIImageView(image: UIImage(resource: .icPlace))
    private let detailPlaceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .Gray500
        label.font = .fontGuide(.caption1)
        return label
    }()
    
    let detailCheckButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .Gray650
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = .fontGuide(.body1)
        button.setBackgroundColor(.Gray650, for: .normal)
        button.setBackgroundColor(.Gray650, for: .selected)
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
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
extension AddRoutinDetailBSViewController {
    
    func setUI() {
        view.backgroundColor = .clear
    }
    
    func bindUI(model: AddRoutineBottomSheetEntity) {
        detailContentLabel.text = model.content.replacingOccurrences(of: "\n", with: " ")
        detailContentLabel.asLineHeight(.body1)
        detailContentLabel.textAlignment = .center
        detailDescriptionLabel.text = model.description
        detailDescriptionLabel.asLineHeight(.body2)
        detailTimeLabel.text = model.time
        detailPlaceLabel.text = model.place
    }
    
    func setHierarchy() {
        contentBackView.addSubview(detailContentLabel)
        bottomSheet.addSubviews(challengeTitleLabel,
                                contentBackView,
                                detailDescriptionLabel,
                                detailTimeIcon,
                                detailTimeLabel,
                                detailPlaceIcon,
                                detailPlaceLabel,
                                detailCheckButton)
        view.addSubviews(backgroundView,
                         bottomSheet)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bottomSheet.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        challengeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
        contentBackView.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 40)
            $0.height.equalTo(SizeLiterals.Screen.deviceRatio > 0.5 ? 112 : 88)
        }
        
        detailContentLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth - 95)
        }
        
        detailDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(contentBackView.snp.bottom).offset(16)
            $0.leading.equalTo(contentBackView.snp.leading)
            $0.trailing.equalTo(contentBackView.snp.trailing)
        }
        
        detailTimeIcon.snp.makeConstraints {
            $0.top.equalTo(detailDescriptionLabel.snp.bottom).offset(24)
            $0.leading.equalTo(detailDescriptionLabel.snp.leading)
            $0.size.equalTo(18)
        }
        
        detailTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(detailTimeIcon)
            $0.leading.equalTo(detailTimeIcon.snp.trailing).offset(6)
        }
        
        detailPlaceIcon.snp.makeConstraints {
            $0.top.equalTo(detailTimeIcon.snp.bottom).offset(8)
            $0.leading.equalTo(detailTimeIcon.snp.leading)
            $0.size.equalTo(18)
        }
        
        detailPlaceLabel.snp.makeConstraints {
            $0.centerY.equalTo(detailPlaceIcon)
            $0.leading.equalTo(detailPlaceIcon.snp.trailing).offset(6)
        }
        
        detailCheckButton.snp.makeConstraints {
            $0.top.equalTo(detailPlaceLabel.snp.bottom).offset(32)
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
        detailCheckButton.addTarget(self,
                                    action: #selector(hideBottomSheetAction),
                                    for: .touchUpInside)
    }
}
