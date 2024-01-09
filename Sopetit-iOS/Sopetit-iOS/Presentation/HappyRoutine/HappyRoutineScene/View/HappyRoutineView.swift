//
//  HappyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

import SnapKit

final class HappyRoutineView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Components
    
    private let navigationBar: CustomNavigationBarView = {
        let navigationBar = CustomNavigationBarView()
        navigationBar.isLeftTitleViewIncluded = true
        navigationBar.isLeftTitleLabelIncluded = "행복 루틴"
        return navigationBar
    }()
    
    private let bearDescriptionView = BearDescriptionView()
    private let emptyHappyRoutineView: UIView = {
        let view = UIView()
        view.backgroundColor = .SoftieWhite
        view.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray100.cgColor
        return view
    }()
    
    private let emptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "진행 중인 행복루틴이 없어요.\n루틴을 추가할까요?"
        label.font = .fontGuide(.body2)
        label.textColor = .Gray300
        label.textAlignment = .center
        label.setLineSpacing(lineSpacing: 4)
        label.numberOfLines = 0
        return label
    }()
    
    private let bearPlusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.HappyRoutine.imgHappyAdd
        return imageView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension HappyRoutineView {

    func setUI() {
        self.backgroundColor = .SoftieBack
    }
    
    func setHierarchy() {
        self.addSubviews(navigationBar, bearDescriptionView, emptyHappyRoutineView)
        emptyHappyRoutineView.addSubviews(emptyTextLabel, bearPlusImageView)
    }
    
    func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        bearDescriptionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.width.equalTo(315)
            $0.height.equalTo(76)
            $0.centerX.equalToSuperview()
        }
        
        emptyHappyRoutineView.snp.makeConstraints {
            $0.top.equalTo(bearDescriptionView.snp.bottom).offset(52/812 * UIScreen.main.bounds.height)
            $0.width.equalTo(280)
            $0.height.equalTo(398)
            $0.centerX.equalToSuperview()
        }
        
        emptyTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(84)
            $0.centerX.equalToSuperview()
        }
        
        bearPlusImageView.snp.makeConstraints {
            $0.top.equalTo(emptyTextLabel.snp.bottom).offset(64)
            $0.centerX.equalToSuperview()
        }
    }
    
    func setAddTarget() {

    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        
    }
    
    func setDataBind() {
        
    }
}
