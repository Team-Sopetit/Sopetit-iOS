//
//  HappyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/11/24.
//

import UIKit

import SnapKit

final class HappyRoutineView: UIView {

    // MARK: - UI Components
    
    private let navigationBar: CustomNavigationBarView = {
        let navigationBar = CustomNavigationBarView()
        navigationBar.isLeftTitleViewIncluded = true
        navigationBar.isLeftTitleLabelIncluded = I18N.HappyRoutine.happyRoutineTitle
        navigationBar.isDeleteButtonIncluded = true
        return navigationBar
    }()
    
    private let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.HappyRoutine.imgSpeechHappy
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bubbleLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.HappyRoutine.achieving
        label.font = .fontGuide(.bubble16)
        label.textColor = .Gray700
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head1)
        label.textColor = .Gray500
        return label
    }()
    
    private let happyRoutineCardView = HappyRoutineCardView()
    private let doneButton = BottomCTAButton(title: I18N.HappyRoutine.done)
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
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

private extension HappyRoutineView {
    
    func setUI() {
        self.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.addSubviews(navigationBar, bubbleImageView, bubbleLabel, subTitleLabel, happyRoutineCardView, doneButton)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        bubbleImageView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(15)
            $0.width.equalTo(88)
            $0.height.equalTo(46)
            $0.centerX.equalToSuperview()
        }
        
        bubbleLabel.snp.makeConstraints {
            $0.centerX.equalTo(bubbleImageView)
            $0.centerY.equalTo(bubbleImageView).offset(-2)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(bubbleImageView.snp.bottom).offset(19)
            $0.horizontalEdges.equalToSuperview().inset(50)
        }
        
        happyRoutineCardView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(280)
            $0.height.equalTo(398)
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(12)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setAddTarget() {
        doneButton.addTarget(self, action: #selector(tapDoneButton), for: .touchUpInside)
    }
    
    @objc func tapDoneButton() {
        print("tapDoneButton")
        /// Show BottomSheet
    }
}

extension HappyRoutineView {
    
    func setDataBind(model: HappyRoutineCard) {
        subTitleLabel.text = model.title
        subTitleLabel.textAlignment = .center
        happyRoutineCardView.bindModel(model: model)
    }
}