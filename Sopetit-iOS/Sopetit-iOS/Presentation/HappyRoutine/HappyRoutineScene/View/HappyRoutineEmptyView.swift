//
//  HappyRoutineView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

import SnapKit

final class HappyRoutineEmptyView: UIView {
    
    // MARK: - Properties
    
    var fromRoutineView: Bool = false {
        didSet {
            setAlertMessage()
        }
    }

    // MARK: - UI Components
    
    private var deleteAlertView = AlertMessageView(title: I18N.HappyRoutine.delAlertTitle)
    
    private let navigationBar: CustomNavigationBarView = {
        let navigationBar = CustomNavigationBarView()
        navigationBar.isLeftTitleViewIncluded = true
        navigationBar.isLeftTitleLabelIncluded = I18N.HappyRoutine.happyRoutineTitle
        return navigationBar
    }()
    
    let bearDescriptionView = BearDescriptionView()
    lazy var emptyHappyRoutineView: UIView = {
        let view = UIView()
        view.backgroundColor = .SoftieWhite
        view.roundCorners(cornerRadius: 20, maskedCorners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner])
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.Gray100.cgColor
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let emptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = I18N.HappyRoutine.addRoutine
        label.font = .fontGuide(.body2)
        label.textColor = .Gray300
        label.setLineSpacing(lineSpacing: 4)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let bearPlusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.HappyRoutine.imgHappyAdd
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

private extension HappyRoutineEmptyView {

    func setUI() {
        self.backgroundColor = .SoftieBack
        deleteAlertView.isHidden = true
    }
    
    func setHierarchy() {
        self.addSubviews(navigationBar, bearDescriptionView, emptyHappyRoutineView, deleteAlertView)
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
        
        deleteAlertView.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(SizeLiterals.Screen.screenWidth * 335 / 375)
            $0.height.equalTo(51)
        }
    }
    
    func setAlertMessage() {
        deleteAlertView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseOut, animations: {
            self.deleteAlertView.alpha = 0.0
        }, completion:  {_ in 
            self.deleteAlertView.isHidden = true
            self.deleteAlertView.alpha = 1.0
        })
    }
}
