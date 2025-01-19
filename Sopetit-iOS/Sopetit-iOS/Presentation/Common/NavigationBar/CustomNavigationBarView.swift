//
//  CustomNavigationBarView.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 1/9/24.
//

import UIKit

import SnapKit

protocol BackButtonProtocol: AnyObject {
    
    func tapBackButton()
}

final class CustomNavigationBarView: UIView {

    weak var delegate: BackButtonProtocol?
    
    // MARK: - Properties
    
    var isLeftTitleViewIncluded: Bool {
        get { !leftTitleView.isHidden }
        set { leftTitleView.isHidden = !newValue }
    }
    
    var isLeftTitleLabelIncluded: String? {
        get { leftTitleLabel.text }
        set { leftTitleLabel.text = newValue }
    }
    
    var isTitleLabelIncluded: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var isTitleViewIncluded: Bool {
        get { !titleView.isHidden }
        set { titleView.isHidden = !newValue }
    }
    
    var isBackButtonIncluded: Bool {
        get { !backButton.isHidden }
        set { backButton.isHidden = !newValue }
    }
    
    var backButtonAction: (() -> Void)?
    
    // MARK: - UI Components
    
    private lazy var leftTitleView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private lazy var leftTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head3)
        label.textColor = .Gray700
        label.textAlignment = .left
        return label
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .fontGuide(.head3)
        label.textColor = .Gray700
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(ImageLiterals.Navi.icChevronBack, for: .normal)
        button.isHidden = true
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7)
        return button
    }()
    
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

private extension CustomNavigationBarView {

    func setUI() {
        self.backgroundColor = .Gray50
    }
    
    func setHierarchy() {
        self.addSubviews(backButton, titleView, leftTitleView)
        titleView.addSubview(titleLabel)
        leftTitleView.addSubview(leftTitleLabel)
    }
    
    func setLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        
        leftTitleView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(100)
            $0.height.equalTo(22)
            $0.centerY.equalToSuperview()
        }
        
        leftTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        titleView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(22)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(38)
        }
    }
    
    func setAddTarget() {
        backButton.addTarget(self, action: #selector(isTapped), for: .touchUpInside)
    }
    
    @objc
    func isTapped(_ sender: UIButton) {
        delegate?.tapBackButton()
    }
}
